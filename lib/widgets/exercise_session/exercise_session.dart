import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:chain_arithmetics/core/generators/common.dart';
import 'package:chain_arithmetics/core/generators/guess_operators/guess_operator.dart';
import 'package:chain_arithmetics/core/generators/guess_operators/guess_operator_generator.dart';
import 'package:chain_arithmetics/core/generators/operations/operation.dart';
import 'package:chain_arithmetics/core/generators/operations/standard_generator.dart';
import 'package:chain_arithmetics/gen/strings.g.dart';
import 'package:chain_arithmetics/pages/summary.dart';
import 'package:chain_arithmetics/utils.dart';
import 'package:chain_arithmetics/widgets/constants.dart';
import 'package:chain_arithmetics/widgets/exercise_session/digit_keyboard.dart';
import 'package:chain_arithmetics/widgets/exercise_session/guess_operator_answer.dart';
import 'package:chain_arithmetics/widgets/exercise_session/operation_answer.dart';
import 'package:chain_arithmetics/widgets/exercise_session/operator_keyboard.dart';
import 'package:chain_arithmetics/widgets/exercise_session/questions_buffer.dart';
import 'package:flutter/material.dart';

enum Mode { oneMinute, questionsCount100 }

enum Type { numbers, operators }

class ExerciseSessionWidget extends StatefulWidget {
  final String title;
  final Mode mode;
  final Type type;

  const ExerciseSessionWidget({
    super.key,
    required this.title,
    required this.mode,
    required this.type,
  });

  @override
  State<ExerciseSessionWidget> createState() => _ExerciseSessionWidgetState();
}

class _ExerciseSessionWidgetState extends State<ExerciseSessionWidget> {
  Timer? _timer;
  int _timeInSeconds = 60;
  Generator _currentQuestions = StandardGenerator.generate(Mode.oneMinute);
  int _firstOperationIndex = 0;
  String? _previousAnswer;
  String _currentAnswer = "";
  int _penaltiesCount = 0;
  bool _timeout = false;
  List<Question> _bufferQuestions = [];
  List<String> _answers = [];

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _generateExercise();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _generateExercise() {
    _timer?.cancel();
    setState(() {
      _currentQuestions = widget.type == Type.numbers
          ? StandardGenerator.generate(widget.mode)
          : GuessOperatorGenerator.generate(widget.mode);
      _answers = [];
      _firstOperationIndex = 0;
      _previousAnswer = null;
      _timeout = false;
      _penaltiesCount = 0;
      _timeInSeconds = widget.mode == Mode.oneMinute ? 60 : 0;
    });
    _updateBuffer();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (_isExerciseOver()) {
        timer.cancel();
        return;
      }
      final timeout =
          (widget.mode == Mode.oneMinute && _timeInSeconds <= 0) ||
          ((widget.mode == Mode.questionsCount100) &&
              (_timeInSeconds >= (60 * maxAllocatedTimeMinutes)));
      if (timeout) {
        setState(() {
          _timeout = true;
        });
        await _playTimeoutSound();
        timer.cancel();
        if (!mounted) return;
        Navigator.of(context).pushReplacement<void, void>(
          MaterialPageRoute(
            builder: (ctx2) {
              return SummaryPage(
                title: widget.title,
                lastTimeStateSeconds: _timeInSeconds,
                penaltyCount: _penaltiesCount,
                questions: _currentQuestions.relatedQuestions(),
                userAnswers: _answers,
                mode: widget.mode,
                type: widget.type,
              );
            },
          ),
        );
      } else {
        setState(() {
          _timeInSeconds += widget.mode == Mode.oneMinute ? -1 : 1;
        });
      }
    });
  }

  void _showQuickTooltip({
    required BuildContext context,
    required String message,
    required Offset position,
    required Color backgroundColor,
    required Duration duration,
    double? fontSize,
    IconData? leadingIcon,
  }) {
    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx,
        top: position.dy,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Row(
                children: [
                  if (leadingIcon != null)
                    Icon(leadingIcon, size: fontSize ?? defaultTooltipFontSize),
                  Text(
                    message,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize ?? defaultTooltipFontSize,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    overlay.insert(entry);
    Future.delayed(duration, entry.remove);
  }

  Future<void> _playTimeoutSound() async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource('sounds/timeout.wav'));
  }

  Future<void> _playSuccessSound() async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource('sounds/correct.wav'));
  }

  Future<void> _playWrongSound() async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource('sounds/wrong.wav'));
  }

  void _updateBuffer() {
    setState(() {
      _bufferQuestions = [];
      final operationsCount = _currentQuestions.relatedQuestions().length;
      for (
        var i = 0;
        (i < maxBufferOperations) &&
            (_firstOperationIndex + i < operationsCount);
        i++
      ) {
        final currentQuestion = _currentQuestions
            .relatedQuestions()[_firstOperationIndex + i];
        _bufferQuestions.add(currentQuestion);
      }
      while (_bufferQuestions.length < maxBufferOperations) {
        _bufferQuestions.add(dummyQuestion);
      }
    });
  }

  bool _isExerciseOver() {
    return _firstOperationIndex >= _currentQuestions.questionsCount() ||
        _timeout;
  }

  void _insertDigit(int digit, BuildContext context) {
    if (_isExerciseOver()) return;
    if (widget.type != Type.numbers) return;

    setState(() {
      _currentAnswer += digit.toString();
    });
    final currentQuestion = _currentQuestions
        .relatedQuestions()[_firstOperationIndex];
    final currentOperation = currentQuestion as Operation;
    final expectedDigitsCount = numberOfDigits(currentOperation.result);
    final userAnswerDigitsCount = _currentAnswer.length;

    if (userAnswerDigitsCount >= expectedDigitsCount) {
      setState(() {
        _answers.add(_currentAnswer);
      });
      _validateAnswer(context);
    }
  }

  void _validateOperator(Operator operator, BuildContext context) {
    setState(() {
      _currentAnswer = operator.stringRepr();
      _answers.add(_currentAnswer);
    });
    _validateAnswer(context);
  }

  void _validateAnswer(BuildContext context) async {
    if (_firstOperationIndex < _currentQuestions.relatedQuestions().length) {
      final currentQuestion = _currentQuestions
          .relatedQuestions()[_firstOperationIndex];
      final isRightAnswer =
          (widget.type == Type.numbers &&
              (currentQuestion as Operation).result.toString() ==
                  _currentAnswer) ||
          (widget.type == Type.operators &&
              (currentQuestion as GuessOperator).expectedOperator
                      .stringRepr() ==
                  _currentAnswer);
      if (isRightAnswer) {
        await _playSuccessSound();
      } else {
        await _playWrongSound();
        if (!context.mounted) return;
        _showQuickTooltip(
          context: context,
          message: "$penaltyTimeSeconds s",
          position: penaltyTooltipOffset,
          backgroundColor: Colors.red,
          duration: Duration(milliseconds: penaltyTooltipDurationMs),
        );
        setState(() {
          _penaltiesCount++;
          _timeInSeconds +=
              penaltyTimeSeconds * (widget.mode == Mode.oneMinute ? -1 : 1);
        });
      }
      setState(() {
        _firstOperationIndex++;
        _previousAnswer = _currentAnswer;
        _currentAnswer = "";
      });
      if (_firstOperationIndex % 5 == 0) {
        if (!context.mounted) return;
        _showQuickTooltip(
          context: context,
          message: _firstOperationIndex.toString(),
          position: flagTooltipOffset,
          backgroundColor: Colors.grey,
          duration: Duration(milliseconds: flagTooltipDurationMs),
          leadingIcon: Icons.flag,
          fontSize: 40.0,
        );
      }
      _updateBuffer();
    }
    if (_isExerciseOver()) {
      _timer?.cancel();
      if (!context.mounted) return;
      Navigator.of(context).pushReplacement<void, void>(
        MaterialPageRoute(
          builder: (ctx2) {
            return SummaryPage(
              title: widget.title,
              lastTimeStateSeconds: _timeInSeconds,
              penaltyCount: _penaltiesCount,
              questions: _currentQuestions.relatedQuestions(),
              userAnswers: _answers,
              mode: widget.mode,
              type: widget.type,
            );
          },
        ),
      );
    }
  }

  void _clearSelection() {
    setState(() {
      _currentAnswer = "";
    });
  }

  String timeString() {
    if (widget.mode == Mode.oneMinute) {
      return t.pages.common.remaining_time(remainingTimeSec: _timeInSeconds);
    }
    final timeMinutes = (_timeInSeconds / 60).floor();
    final timeSeconds = _timeInSeconds % 60;
    return t.pages.common.elapsed_time(
      elapsedMinutes: timeMinutes,
      elapedSeconds: timeSeconds,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (_firstOperationIndex > 0 && _previousAnswer != null)
                  Container(
                    color: Colors.brown.shade300,
                    child: widget.type == Type.numbers
                        ? OperationAnswerWidget(
                            operation:
                                _currentQuestions
                                        .relatedQuestions()[_firstOperationIndex -
                                        1]
                                    as Operation,
                            userAnswer: _previousAnswer!,
                          )
                        : GuessOperatorAnswerWidget(
                            guessOperator:
                                _currentQuestions
                                        .relatedQuestions()[_firstOperationIndex -
                                        1]
                                    as GuessOperator,
                            userAnswer: _previousAnswer!,
                          ),
                  ),
                if (widget.type == Type.numbers)
                  Text(
                    _currentAnswer.isNotEmpty ? _currentAnswer : "_",
                    style: TextStyle(
                      fontSize: commonFontSize,
                      fontWeight: FontWeight(commonFontWeight),
                      color: Colors.black,
                    ),
                  ),
                Container(
                  color: Colors.blue.shade200,
                  child: QuestionsBufferWidget(
                    questions: _bufferQuestions,
                    capacity: maxBufferOperations,
                  ),
                ),
              ],
            ),
            Container(
              height: double.infinity,
              color: Colors.white.withAlpha(210),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        timeString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    widget.type == Type.numbers
                        ? DigitalKeyboardWidget(
                            insertDigit: (digit) =>
                                _insertDigit(digit, context),
                            clearSelection: _clearSelection,
                          )
                        : OperatorKeyboardWidget(
                            setOperator: (operator) =>
                                _validateOperator(operator, context),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
