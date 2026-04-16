import 'package:chain_arithmetics/core/generators/operations/operation.dart';
import 'package:chain_arithmetics/widgets/exercise_session/question.dart';
import 'package:flutter/material.dart';
import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:animated_list_plus/transitions.dart';

const animationDurationMs = 500;

class QuestionsBufferWidget extends StatelessWidget {
  final List<Operation> questions;
  final int capacity;

  const QuestionsBufferWidget({
    super.key,
    required this.questions,
    required this.capacity,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ImplicitlyAnimatedList<Operation>(
        items: questions,
        areItemsTheSame: (a, b) => a == b,
        insertDuration: Duration(milliseconds: animationDurationMs),
        removeDuration: Duration(milliseconds: animationDurationMs),
        itemBuilder: (context, animation, item, index) {
          return SizeFadeTransition(
            animation: animation,
            child: Align(
              alignment: Alignment.center,
              child: QuestionWidget(relatedQuestion: item),
            ),
          );
        },
        removeItemBuilder: (context, animation, oldItem) {
          return SizeFadeTransition(
            animation: animation,
            child: Align(
              alignment: Alignment.center,
              child: QuestionWidget(relatedQuestion: oldItem),
            ),
          );
        },
        shrinkWrap: true,
      ),
    );
  }
}
