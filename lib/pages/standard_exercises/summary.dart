import 'package:chain_arithmetics/core/generators/operations/operation.dart';
import 'package:chain_arithmetics/gen/strings.g.dart';
import 'package:chain_arithmetics/widgets/constants.dart';
import 'package:chain_arithmetics/widgets/exercise_session/exercise_session.dart';
import 'package:chain_arithmetics/widgets/exercise_session/question_answer.dart';
import 'package:flutter/material.dart';

class SummaryPage extends StatelessWidget {
  final int lastTimeStateSeconds;
  final int penaltyCount;
  final List<Operation> questions;
  final List<int> userAnswers;
  final String title;
  final Mode mode;

  const SummaryPage({
    super.key,
    required this.title,
    required this.lastTimeStateSeconds,
    required this.penaltyCount,
    required this.questions,
    required this.userAnswers,
    required this.mode,
  });

  String timeString() {
    if (mode == Mode.oneMinute) {
      return t.pages.common.remaining_time(
        remainingTimeSec: lastTimeStateSeconds,
      );
    }
    final timeMinutes = (lastTimeStateSeconds / 60).floor();
    final timeSeconds = lastTimeStateSeconds % 60;
    return t.pages.common.elapsed_time(
      elapsedMinutes: timeMinutes,
      elapedSeconds: timeSeconds,
    );
  }

  String penaltyString() {
    if (mode == Mode.oneMinute) {
      return t.pages.common.penalty.one_minute_mode(
        penaltyCount: penaltyCount,
        penaltyTimeSeconds: penaltyTimeSeconds,
        totalPenaltyTimeSeconds: penaltyCount * penaltyTimeSeconds,
      );
    }
    final cumulatedPenalty = penaltyCount * penaltyTimeSeconds;
    final totalPenaltyTimeMinutes = (cumulatedPenalty / 60).floor();
    final totalPenaltyTimeSeconds = cumulatedPenalty % 60;
    return t.pages.common.penalty.one_hundred_questions_mode(
      penaltyCount: penaltyCount,
      penaltyTimeSeconds: penaltyTimeSeconds,
      totalPenaltyTimeMinutes: totalPenaltyTimeMinutes,
      totalPenaltyTimeSeconds: totalPenaltyTimeSeconds,
    );
  }

  @override
  Widget build(BuildContext context) {
    final timeout =
        (mode == Mode.oneMinute && lastTimeStateSeconds <= 0) ||
        (mode == Mode.questionsCount100 &&
            lastTimeStateSeconds >= maxAllocatedTimeMinutes * 60);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (timeout)
            Text(t.pages.common.timeout, style: TextStyle(fontSize: 30)),
          if (!timeout)
            Text(
              timeString(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          Text(
            penaltyString(),
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
