import 'package:chain_arithmetics/core/generators/operations/operation.dart';
import 'package:flutter/material.dart';

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
  Operation _currentOperation = Operation.randomOperation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Home"),
      ),
      body: Center(
        child: Row(
          children: [
            Text(_currentOperation.questionRepr()),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _currentOperation = Operation.randomOperation();
                });
              },
              child: Text("Change operation"),
            ),
          ],
        ),
      ),
    );
  }
}
