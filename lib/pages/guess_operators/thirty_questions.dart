import 'package:chain_arithmetics/gen/strings.g.dart';
import 'package:chain_arithmetics/widgets/constants.dart';
import 'package:chain_arithmetics/widgets/exercise_session/exercise_session.dart';
import 'package:flutter/material.dart';

class ThirtyQuestionsGuessOperatorsPage extends StatelessWidget {
  const ThirtyQuestionsGuessOperatorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ExerciseSessionWidget(
      title: t.pages.guess_operator.thirtyQuestions.title(
        oneMinuteModeQuestionsCount: oneMinuteModeQuestionsCount,
      ),
      mode: Mode.oneMinute,
      type: Type.operators,
    );
  }
}
