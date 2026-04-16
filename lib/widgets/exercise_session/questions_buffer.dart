import 'package:chain_arithmetics/core/generators/operations/operation.dart';
import 'package:flutter/material.dart';
import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:animated_list_plus/transitions.dart';

const commonFontSize = 60.0;
const commonFontWeight = 900;
final dummyOperation = Operation(
  operand_1: 0,
  operand_2: 0,
  result: 0,
  relatedOperator: Operator.add,
);

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
        itemBuilder: (context, animation, item, index) {
          return SizeFadeTransition(
            animation: animation,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                item.questionRepr(),
                style: TextStyle(
                  fontSize: commonFontSize,
                  fontWeight: FontWeight(commonFontWeight),
                  color: item == dummyOperation
                      ? Colors.transparent
                      : Colors.black,
                ),
              ),
            ),
          );
        },
        removeItemBuilder: (context, animation, oldItem) {
          return SizeFadeTransition(
            animation: animation,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                oldItem.questionRepr(),
                style: TextStyle(
                  fontSize: commonFontSize,
                  fontWeight: FontWeight(commonFontWeight),
                  color: oldItem == dummyOperation
                      ? Colors.transparent
                      : Colors.black,
                ),
              ),
            ),
          );
        },
        shrinkWrap: true,
      ),
    );
  }
}
