import 'package:chain_arithmetics/core/generators/operations/operation.dart';
import 'package:chain_arithmetics/core/generators/operations/standard_generator.dart';
import 'package:chain_arithmetics/utils.dart';
import 'package:chain_arithmetics/widgets/constants.dart';
import 'package:chain_arithmetics/widgets/exercise_session/digit_keyboard.dart';
import 'package:chain_arithmetics/widgets/exercise_session/question_answer.dart';
import 'package:chain_arithmetics/widgets/exercise_session/questions_buffer.dart';
import 'package:flutter/material.dart';
import 'dart:async';

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
  bool _timeout = false;
  List<Operation> _bufferQuestions = [];

  @override
  void initState() {
    super.initState();
    _generateExercise();
  }

  void _generateExercise() {
    _timer?.cancel();
    setState(() {
      _currentOperations = StandardGenerator.generate();
      _firstOperationIndex = 0;
      _previousAnswer = null;
      _timeout = false;
      _remainingSeconds = 60;
    });
    _updateBuffer();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isExerciseOver()) {
        timer.cancel();
        return;
      }
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        }
        if (_remainingSeconds == 0) {
          _timeout = true;
          timer.cancel();
        }
      });
    });
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

  void _insertDigit(int digit) {
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
      _validateAnswer();
    }
  }

  void _validateAnswer() {
    if (_firstOperationIndex < _currentOperations.relatedOperations().length) {
      setState(() {
        _firstOperationIndex++;
        _previousAnswer = _currentAnswer;
        _currentAnswer = 0;
      });
      _updateBuffer();
    }
    if (_isExerciseOver()) {
      _timer?.cancel();
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
                  QuestionAnswerWidget(
                    operation: _currentOperations
                        .relatedOperations()[_firstOperationIndex - 1],
                    userAnswer: _previousAnswer!,
                  ),
                QuestionsBufferWidget(
                  questions: _bufferQuestions,
                  capacity: maxBufferOperations,
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
                          DigitalKeyboardWidget(insertDigit: _insertDigit),
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
