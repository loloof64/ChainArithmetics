import 'dart:math';

import 'package:chain_arithmetics/core/generators/common.dart';

Random _random = Random();

class GuessOperator extends Question {
  final int operand_1;
  final int operand_2;
  final Operator expectedOperator;
  final int result;

  GuessOperator({
    required this.operand_1,
    required this.operand_2,
    required this.expectedOperator,
    required this.result,
  });

  @override
  String questionRepr() {
    return "$operand_1 _ $operand_2 = $result";
  }

  String answerReprPart1() {
    return "$operand_1  ";
  }

  String answerReprPart2() {
    return "  $operand_2 = $result";
  }

  @override
  bool isCorrectAnswer(String answer) {
    return switch (answer) {
      "" => false,
      "+" => operand_1 + operand_2 == result,
      "-" => operand_1 - operand_2 == result,
      "*" => operand_1 * operand_2 == result,
      "/" => operand_1 / operand_2 == result,
      _ => throw "unknown operator $answer",
    };
  }

  factory GuessOperator.randomAddition() {
    final oper1 = _random.nextInt(8) + 2;
    final oper2 = _random.nextInt(8) + 2;
    final result = oper1 + oper2;

    return GuessOperator(
      operand_1: oper1,
      operand_2: oper2,
      result: result,
      expectedOperator: Operator.add,
    );
  }

  factory GuessOperator.randomSubstraction() {
    final oper2 = _random.nextInt(8) + 2;
    final result = _random.nextInt(8) + 2;
    final oper1 = oper2 + result;

    return GuessOperator(
      operand_1: oper1,
      operand_2: oper2,
      result: result,
      expectedOperator: Operator.sub,
    );
  }

  factory GuessOperator.randomMultiplication() {
    final oper1 = _random.nextInt(8) + 2;
    final oper2 = _random.nextInt(8) + 2;
    final result = oper1 * oper2;

    return GuessOperator(
      operand_1: oper1,
      operand_2: oper2,
      result: result,
      expectedOperator: Operator.mult,
    );
  }

  factory GuessOperator.randomDivision() {
    final oper2 = _random.nextInt(8) + 2;
    final result = _random.nextInt(8) + 2;
    final oper1 = oper2 * result;

    return GuessOperator(
      operand_1: oper1,
      operand_2: oper2,
      result: result,
      expectedOperator: Operator.divide,
    );
  }

  factory GuessOperator.randomGuessOperator() {
    final type = _random.nextInt(4);
    return switch (type) {
      0 => GuessOperator.randomAddition(),
      1 => GuessOperator.randomSubstraction(),
      2 => GuessOperator.randomMultiplication(),
      3 => GuessOperator.randomDivision(),
      _ => throw "Invalid operation type cardinal",
    };
  }
}
