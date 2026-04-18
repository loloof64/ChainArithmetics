import 'package:chain_arithmetics/gen/strings.g.dart';
import 'package:chain_arithmetics/widgets/exercise_session/exercise_session.dart';
import 'package:flutter/material.dart';

class OneHundredQuestionsStandardPage extends StatelessWidget {
  const OneHundredQuestionsStandardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ExerciseSessionWidget(
      title: t.pages.standard_exercises.oneHundredQuestions.title,
      mode: Mode.questionsCount100,
    );
  }
}
