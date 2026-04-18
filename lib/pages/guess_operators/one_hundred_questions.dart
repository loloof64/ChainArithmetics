import 'package:chain_arithmetics/gen/strings.g.dart';
import 'package:chain_arithmetics/widgets/exercise_session/exercise_session.dart';
import 'package:flutter/material.dart';

class OneHundredQuestionsGuessOperatorPage extends StatelessWidget {
  const OneHundredQuestionsGuessOperatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ExerciseSessionWidget(
      title: t.pages.guess_operator.oneHundredQuestions.title,
      mode: Mode.questionsCount100,
      type: Type.operators,
    );
  }
}
