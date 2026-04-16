import 'package:chain_arithmetics/core/generators/operations/operation.dart';
import 'package:chain_arithmetics/widgets/constants.dart';
import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final Operation relatedQuestion;

  const QuestionWidget({super.key, required this.relatedQuestion});

  @override
  Widget build(BuildContext context) {
    return Text(
      relatedQuestion.questionRepr(),
      style: TextStyle(
        fontSize: commonFontSize,
        fontWeight: FontWeight(commonFontWeight),
        color: relatedQuestion == dummyOperation
            ? Colors.transparent
            : Colors.black,
      ),
    );
  }
}
