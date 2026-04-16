import 'dart:math';

import 'package:chain_arithmetics/core/generators/operations/operation.dart';
import 'package:chain_arithmetics/core/generators/operations/standard_generator.dart';
import 'package:chain_arithmetics/utils.dart';
import 'package:chain_arithmetics/widgets/constants.dart';
import 'package:chain_arithmetics/widgets/exercise_session/digit_keyboard.dart';
import 'package:chain_arithmetics/widgets/exercise_session/question_answer.dart';
import 'package:chain_arithmetics/widgets/exercise_session/questions_buffer.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const maxBufferOperations = 5;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chain arithmetics',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StandardGenerator _currentOperations = StandardGenerator.generate();
  int _firstOperationIndex = 0;
  int? _previousAnswer;
  int _currentAnswer = 0;
  List<Operation> _bufferQuestions = [];

  @override
  void initState() {
    super.initState();
    _generateExercise();
  }

  void _generateExercise() {
    setState(() {
      _currentOperations = StandardGenerator.generate();
      _firstOperationIndex = 0;
      _previousAnswer = null;
    });
    _updateBuffer();
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

  void _insertDigit(int digit) {
    final isExerciseOver =
        _firstOperationIndex >= _currentOperations.operations.length;

    if (isExerciseOver) return;

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Home"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            DigitalKeyboardWidget(insertDigit: _insertDigit),
          ],
        ),
      ),
    );
  }
}
