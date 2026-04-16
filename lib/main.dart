import 'package:chain_arithmetics/core/generators/operations/operation.dart';
import 'package:chain_arithmetics/core/generators/operations/standard_generator.dart';
import 'package:chain_arithmetics/widgets/exercise_session/questions_buffer.dart';
import 'package:flutter/material.dart';

const maxBufferOperations = 5;

void main() {
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

  void _gotoNextQuestion() {
    if (_firstOperationIndex < _currentOperations.relatedOperations().length) {
      setState(() {
        _firstOperationIndex++;
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
            QuestionsBufferWidget(
              questions: _bufferQuestions,
              capacity: maxBufferOperations,
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _generateExercise();
                    },
                    child: Text("Change exercise"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _gotoNextQuestion();
                    },
                    child: Text("Next question"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
