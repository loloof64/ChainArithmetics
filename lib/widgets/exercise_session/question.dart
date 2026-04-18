import 'package:chain_arithmetics/core/generators/common.dart';
import 'package:chain_arithmetics/widgets/constants.dart';
import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final Question relatedQuestion;

  const QuestionWidget({super.key, required this.relatedQuestion});

  @override
  Widget build(BuildContext context) {
    return Text(
      relatedQuestion.questionRepr(),
      style: TextStyle(
        fontSize: commonFontSize,
        fontWeight: FontWeight(commonFontWeight),
        color: relatedQuestion is DummyQuestion
            ? Colors.transparent
            : Colors.black,
      ),
    );
  }
}
