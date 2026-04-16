import 'package:chain_arithmetics/core/generators/operations/operation.dart';
import 'package:chain_arithmetics/widgets/constants.dart';
import 'package:flutter/material.dart';

class QuestionAnswerWidget extends StatelessWidget {
  final Operation operation;
  final int? userAnswer;

  const QuestionAnswerWidget({
    super.key,
    required this.operation,
    required this.userAnswer,
  });

  @override
  Widget build(BuildContext context) {
    final isRightAnswer = operation.result == userAnswer;
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: operation.questionRepr(),
            style: TextStyle(
              fontSize: commonFontSize,
              fontWeight: FontWeight(commonFontWeight),
              color: Colors.black,
            ),
          ),
          if (isRightAnswer)
            TextSpan(
              text: operation.result.toString(),
              style: TextStyle(
                fontSize: commonFontSize,
                fontWeight: FontWeight(commonFontWeight),
                color: Colors.green,
              ),
            ),
          if (!isRightAnswer)
            TextSpan(
              text: userAnswer == null ? "__" : userAnswer.toString(),
              style: TextStyle(
                fontSize: commonFontSize,
                fontWeight: FontWeight(commonFontWeight),
                color: Colors.red,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          if (!isRightAnswer)
            TextSpan(
              text: " ${operation.result.toString()}",
              style: TextStyle(
                fontSize: commonFontSize,
                fontWeight: FontWeight(commonFontWeight),
                color: Colors.blue,
              ),
            ),
        ],
      ),
    );
  }
}
