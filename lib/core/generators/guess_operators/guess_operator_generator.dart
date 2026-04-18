import 'package:chain_arithmetics/core/generators/common.dart';
import 'package:chain_arithmetics/core/generators/guess_operators/guess_operator.dart';
import 'package:chain_arithmetics/widgets/constants.dart';
import 'package:chain_arithmetics/widgets/exercise_session/exercise_session.dart';

class GuessOperatorGenerator extends Generator {
  final List<Question> guessOperators;

  GuessOperatorGenerator._({required this.guessOperators});

  @override
  List<Question> relatedQuestions() => guessOperators;

  String questionRepr() {
    return guessOperators.map((e) => e.questionRepr()).join("\n");
  }

  factory GuessOperatorGenerator.generate(Mode mode) {
    final questionsCount = mode == Mode.oneMinute
        ? oneMinuteModeQuestionsCount
        : 100;
    var guessOperatorsList = <GuessOperator>[];
    for (var i = 0; i < questionsCount; i++) {
      guessOperatorsList.add(GuessOperator.randomGuessOperator());
    }
    return GuessOperatorGenerator._(guessOperators: guessOperatorsList);
  }

  @override
  int questionsCount() {
    return guessOperators.length;
  }
}
