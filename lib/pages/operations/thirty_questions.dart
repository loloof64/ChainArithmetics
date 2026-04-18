import 'package:chain_arithmetics/gen/strings.g.dart';
import 'package:chain_arithmetics/widgets/constants.dart';
import 'package:chain_arithmetics/widgets/exercise_session/exercise_session.dart';
import 'package:flutter/material.dart';

class ThirtyQuestionsStandardPage extends StatelessWidget {
  const ThirtyQuestionsStandardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ExerciseSessionWidget(
      title: t.pages.standard_exercises.thirtyQuestions.title(
        oneMinuteModeQuestionsCount: oneMinuteModeQuestionsCount,
      ),
      mode: Mode.oneMinute,
      type: Type.numbers,
    );
  }
}
