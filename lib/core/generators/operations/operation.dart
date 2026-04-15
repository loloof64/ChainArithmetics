import 'dart:math';

Random _random = Random();

enum Operator { add, sub, mult, divide }

extension OperatorExtension on Operator {
  String stringRepr() {
    return switch (this) {
      Operator.add => "+",
      Operator.sub => "-",
      Operator.mult => "*",
      Operator.divide => "/",
    };
  }
}

class Operation {
  final int operand_1;
  final int operand_2;
  final int result;
  final Operator relatedOperator;

  Operation._({
    required this.operand_1,
    required this.operand_2,
    required this.result,
    required this.relatedOperator,
  });

  String questionRepr() {
    return "$operand_1 ${relatedOperator.stringRepr()} $operand_2 = ";
  }

  factory Operation.randomAddition() {
    final oper1 = _random.nextInt(8) + 2;
    final oper2 = _random.nextInt(8) + 2;
    final result = oper1 + oper2;

    return Operation._(
      operand_1: oper1,
      operand_2: oper2,
      result: result,
      relatedOperator: Operator.add,
    );
  }

  factory Operation.randomSubstraction() {
    final oper2 = _random.nextInt(8) + 2;
    final result = _random.nextInt(8) + 2;
    final oper1 = oper2 + result;

    return Operation._(
      operand_1: oper1,
      operand_2: oper2,
      result: result,
      relatedOperator: Operator.sub,
    );
  }

  factory Operation.randomMultiplication() {
    final oper1 = _random.nextInt(8) + 2;
    final oper2 = _random.nextInt(8) + 2;
    final result = oper1 * oper2;

    return Operation._(
      operand_1: oper1,
      operand_2: oper2,
      result: result,
      relatedOperator: Operator.mult,
    );
  }

  factory Operation.randomDivision() {
    final oper2 = _random.nextInt(8) + 2;
    final result = _random.nextInt(8) + 2;
    final oper1 = oper2 * result;

    return Operation._(
      operand_1: oper1,
      operand_2: oper2,
      result: result,
      relatedOperator: Operator.divide,
    );
  }

  factory Operation.randomOperation() {
    final type = _random.nextInt(4);
    return switch (type) {
      0 => Operation.randomAddition(),
      1 => Operation.randomSubstraction(),
      2 => Operation.randomMultiplication(),
      3 => Operation.randomDivision(),
      _ => throw "Invalid operation type cardinal",
    };
  }
}
