import 'package:chain_arithmetics/core/generators/operations/operation.dart';
import 'package:chain_arithmetics/widgets/constants.dart';
import 'package:chain_arithmetics/widgets/exercise_session/question_answer.dart';
import 'package:flutter/material.dart';

class SummaryPage extends StatelessWidget {
  final int remainingTimeSeconds;
  final int penaltyCount;
  final List<Operation> questions;
  final List<int> userAnswers;

  const SummaryPage({
    super.key,
    required this.remainingTimeSeconds,
    required this.penaltyCount,
    required this.questions,
    required this.userAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Summary (35 questions / 1 min)"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (remainingTimeSeconds == 0)
            Text("Time out !", style: TextStyle(fontSize: 30)),
          if (remainingTimeSeconds > 0)
            Text(
              "Remaining time : $remainingTimeSeconds s",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          Text(
            "Penalty: $penaltyCount * ${penaltyTimeSeconds}s = ${penaltyCount * penaltyTimeSeconds}s",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final currentOperation = questions[index];
                final currentAnswer = index >= userAnswers.length
                    ? null
                    : userAnswers[index];
                return QuestionAnswerWidget(
                  operation: currentOperation,
                  userAnswer: currentAnswer,
                );
              },
              itemCount: questions.length,
            ),
          ),
        ],
      ),
    );
  }
}
