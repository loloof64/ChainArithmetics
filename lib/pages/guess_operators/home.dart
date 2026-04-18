import 'package:chain_arithmetics/gen/strings.g.dart';
import 'package:chain_arithmetics/pages/guess_operators/one_hundred_questions.dart';
import 'package:chain_arithmetics/pages/guess_operators/thirty_questions.dart';
import 'package:flutter/material.dart';

class GuessOperatorHomePage extends StatelessWidget {
  const GuessOperatorHomePage({super.key});

  void _goToThirtyQuestions(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx2) {
          return ThirtyQuestionsGuessOperatorsPage();
        },
      ),
    );
  }

  void _goToOneHundredQuestions(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx2) {
          return OneHundredQuestionsGuessOperatorPage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.pages.guess_operator.home.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 15,
          children: [
            ElevatedButton(
              onPressed: () => _goToThirtyQuestions(context),
              child: Text(t.pages.guess_operator.home.gotoThirtyQuestions),
            ),
            ElevatedButton(
              onPressed: () => _goToOneHundredQuestions(context),
              child: Text(t.pages.guess_operator.home.gotoOneHundredQuestions),
            ),
          ],
        ),
      ),
    );
  }
}
