import 'package:chain_arithmetics/gen/strings.g.dart';
import 'package:chain_arithmetics/pages/standard_exercises/thirty_questions/exercise_session.dart';
import 'package:flutter/material.dart';

class StandardExercisesHomePage extends StatelessWidget {
  const StandardExercisesHomePage({super.key});

  void _goToThirtyQuestions(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx2) {
          return ThirtyQuestionsStandardPage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.pages.standard_exercises.home.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 5,
          children: [
            ElevatedButton(
              onPressed: () => _goToThirtyQuestions(context),
              child: Text(t.pages.standard_exercises.home.gotoThirtyQuestions),
            ),
          ],
        ),
      ),
    );
  }
}
