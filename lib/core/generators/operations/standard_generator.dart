import 'package:chain_arithmetics/core/generators/common.dart';
import 'package:chain_arithmetics/core/generators/operations/operation.dart';
import 'package:chain_arithmetics/widgets/constants.dart';
import 'package:chain_arithmetics/widgets/exercise_session/exercise_session.dart';

class StandardGenerator extends Generator {
  final List<Question> operations;

  StandardGenerator._({required this.operations});

  @override
  List<Question> relatedQuestions() => operations;

  String questionRepr() {
    return operations.map((e) => e.questionRepr()).join("\n");
  }

  factory StandardGenerator.generate(Mode mode) {
    final questionsCount = mode == Mode.oneMinute
        ? oneMinuteModeQuestionsCount
        : 100;
    var operationsList = <Operation>[];
    for (var i = 0; i < questionsCount; i++) {
      operationsList.add(Operation.randomOperation());
    }
    return StandardGenerator._(operations: operationsList);
  }

  @override
  int questionsCount() {
    return operations.length;
  }
}
