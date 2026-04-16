import 'package:chain_arithmetics/core/generators/operations/operation.dart';
import 'package:flutter/material.dart';

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
    final questionsWidgets = questions
        .map(
          (e) => Text(
            e.questionRepr(),
            style: TextStyle(
              fontSize: commonFontSize,
              fontWeight: FontWeight(commonFontWeight),
              color: e == dummyOperation ? Colors.transparent : Colors.black,
            ),
          ),
        )
        .toList();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: questionsWidgets,
      ),
    );
  }
}
