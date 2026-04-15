import 'package:chain_arithmetics/core/generators/operations/operation.dart';

const questionsCount = 30;

class StandardGenerator {
  final List<Operation> operations;

  StandardGenerator._({required this.operations});

  List<Operation> relatedOperations() => operations;

  String questionRepr() {
    return operations.map((e) => e.questionRepr()).join("\n");
  }

  factory StandardGenerator.generate() {
    var operationsList = <Operation>[];
    for (var i = 0; i < questionsCount; i++) {
      operationsList.add(Operation.randomOperation());
    }
    return StandardGenerator._(operations: operationsList);
  }
}
