import 'package:chain_arithmetics/core/generators/operations/operation.dart';
import 'package:chain_arithmetics/core/generators/operations/standard_generator.dart';
import 'package:chain_arithmetics/pages/standard_exercises/thirty_questions/summary.dart';
import 'package:chain_arithmetics/utils.dart';
import 'package:chain_arithmetics/widgets/constants.dart';
import 'package:chain_arithmetics/widgets/exercise_session/digit_keyboard.dart';
import 'package:chain_arithmetics/widgets/exercise_session/question_answer.dart';
import 'package:chain_arithmetics/widgets/exercise_session/questions_buffer.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

const flagTooltipDurationMs = 650;
const penaltyTooltipDurationMs = 600;
final flagTooltipOffset = Offset(30, 100);
final penaltyTooltipOffset = Offset(300, 100);

class ThirtyQuestionsStandardPage extends StatefulWidget {
  const ThirtyQuestionsStandardPage({super.key});

  @override
  State<ThirtyQuestionsStandardPage> createState() =>
      _ThirtyQuestionsStandardPageState();
}

class _ThirtyQuestionsStandardPageState
    extends State<ThirtyQuestionsStandardPage> {
  Timer? _timer;
  int _remainingSeconds = 60;
  StandardGenerator _currentOperations = StandardGenerator.generate();
  int _firstOperationIndex = 0;
  int? _previousAnswer;
  int _currentAnswer = 0;
  int _penaltiesCount = 0;
  bool _timeout = false;
  List<Operation> _bufferQuestions = [];
  List<int> _answers = [];

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
      _currentOperations = StandardGenerator.generate();
      _answers = [];
      _firstOperationIndex = 0;
      _previousAnswer = null;
      _timeout = false;
      _penaltiesCount = 0;
      _remainingSeconds = 60;
    });
    _updateBuffer();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (_isExerciseOver()) {
        timer.cancel();
        return;
      }
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      }
      if (_remainingSeconds == 0) {
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
                remainingTimeSeconds: _remainingSeconds,
                penaltyCount: _penaltiesCount,
                questions: _currentOperations.relatedOperations(),
                userAnswers: _answers,
              );
            },
          ),
        );
      }
    });
  }

  void _showQuickTooltip({
    required BuildContext context,
    required String message,
    required Offset position,
    required Color backgroundColor,
    required Duration duration,
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Row(
                children: [
                  if (leadingIcon != null) Icon(leadingIcon),
                  Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
      final operationsCount = _currentOperations.relatedOperations().length;
      for (
        var i = 0;
        (i < maxBufferOperations) &&
            (_firstOperationIndex + i < operationsCount);
        i++
      ) {
        final currentQuestion = _currentOperations
            .relatedOperations()[_firstOperationIndex + i];
        _bufferQuestions.add(currentQuestion);
      }
      while (_bufferQuestions.length < maxBufferOperations) {
        _bufferQuestions.add(dummyOperation);
      }
    });
  }

  bool _isExerciseOver() {
    return _firstOperationIndex >= _currentOperations.operations.length ||
        _timeout;
  }

  void _insertDigit(int digit, BuildContext context) {
    if (_isExerciseOver()) return;

    setState(() {
      _currentAnswer *= 10;
      _currentAnswer += digit;
    });
    final currentQuestion = _currentOperations
        .relatedOperations()[_firstOperationIndex];
    final expectedDigitsCount = numberOfDigits(currentQuestion.result);
    final userAnswerDigitsCount = numberOfDigits(_currentAnswer);

    if (userAnswerDigitsCount >= expectedDigitsCount) {
      setState(() {
        _answers.add(_currentAnswer);
      });
      _validateAnswer(context);
    }
  }

  void _validateAnswer(BuildContext context) async {
    if (_firstOperationIndex < _currentOperations.relatedOperations().length) {
      final expectedResult = _currentOperations
          .relatedOperations()[_firstOperationIndex]
          .result;
      final isRightAnswer = expectedResult == _currentAnswer;
      if (isRightAnswer) {
        await _playSuccessSound();
      } else {
        await _playWrongSound();
        if (!context.mounted) return;
        _showQuickTooltip(
          context: context,
          message: "2s",
          position: penaltyTooltipOffset,
          backgroundColor: Colors.red,
          duration: Duration(milliseconds: penaltyTooltipDurationMs),
        );
        setState(() {
          _penaltiesCount++;
          _remainingSeconds -= penaltyTimeSeconds;
        });
      }
      setState(() {
        _firstOperationIndex++;
        _previousAnswer = _currentAnswer;
        _currentAnswer = 0;
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
              remainingTimeSeconds: _remainingSeconds,
              penaltyCount: _penaltiesCount,
              questions: _currentOperations.relatedOperations(),
              userAnswers: _answers,
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Home"),
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
                    child: QuestionAnswerWidget(
                      operation: _currentOperations
                          .relatedOperations()[_firstOperationIndex - 1],
                      userAnswer: _previousAnswer!,
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
            _isExerciseOver()
                ? Center(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.white.withAlpha(210),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (_timeout)
                            Text("Time out !", style: TextStyle(fontSize: 30)),
                          if (!_timeout)
                            Text(
                              "Remaining time : $_remainingSeconds s",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ],
                      ),
                    ),
                  )
                : Container(
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
                              "Remaining time : $_remainingSeconds s",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DigitalKeyboardWidget(
                            insertDigit: (digit) =>
                                _insertDigit(digit, context),
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
