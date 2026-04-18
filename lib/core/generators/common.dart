enum Operator {
  add,
  sub,
  mult,
  divide;

  String stringRepr() {
    return switch (this) {
      Operator.add => "+",
      Operator.sub => "-",
      Operator.mult => "*",
      Operator.divide => "/",
    };
  }
}

abstract class Question {
  String questionRepr();

  bool isCorrectAnswer(String answer);
}

class DummyQuestion extends Question {
  @override
  bool isCorrectAnswer(String answer) {
    return false;
  }

  @override
  String questionRepr() {
    return "";
  }
}

abstract class Generator {
  List<Question> relatedQuestions();
  int questionsCount();
}
