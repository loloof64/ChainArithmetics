import 'package:chain_arithmetics/core/generators/guess_operators/guess_operator.dart';
import 'package:chain_arithmetics/widgets/constants.dart';
import 'package:flutter/material.dart';

class GuessOperatorAnswerWidget extends StatelessWidget {
  final GuessOperator guessOperator;
  final String? userAnswer;

  const GuessOperatorAnswerWidget({
    super.key,
    required this.guessOperator,
    required this.userAnswer,
  });

  @override
  Widget build(BuildContext context) {
    final isRightAnswer = guessOperator.isCorrectAnswer(userAnswer ?? "");
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: guessOperator.answerReprPart1(),
            style: TextStyle(
              fontSize: commonFontSize,
              fontWeight: FontWeight(commonFontWeight),
              color: Colors.black,
            ),
          ),
          if (isRightAnswer)
            TextSpan(
              text: userAnswer!,
              style: TextStyle(
                fontSize: commonFontSize,
                fontWeight: FontWeight(commonFontWeight),
                color: Colors.green,
              ),
            ),
          if (!isRightAnswer)
            TextSpan(
              text: (userAnswer == null || userAnswer!.isEmpty)
                  ? "_"
                  : userAnswer,
              style: TextStyle(
                fontSize: commonFontSize,
                fontWeight: FontWeight(commonFontWeight),
                color: Colors.red,
                decoration: (userAnswer == null || userAnswer!.isEmpty)
                    ? TextDecoration.none
                    : TextDecoration.underline,
              ),
            ),
          if (!isRightAnswer)
            TextSpan(
              text: " ${guessOperator.expectedOperator.stringRepr()}",
              style: TextStyle(
                fontSize: commonFontSize,
                fontWeight: FontWeight(commonFontWeight),
                color: Colors.blue,
              ),
            ),
          TextSpan(
            text: guessOperator.answerReprPart2(),
            style: TextStyle(
              fontSize: commonFontSize,
              fontWeight: FontWeight(commonFontWeight),
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
