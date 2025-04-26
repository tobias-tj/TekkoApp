class CreateTaskModel {
  final String token;
  final int number1;
  final int number2;
  final String operation;
  final int correctAnswer;

  CreateTaskModel(
      {required this.token,
      required this.number1,
      required this.number2,
      required this.operation,
      required this.correctAnswer});

  Map<String, dynamic> toJson() => {
        'number1': number1,
        'number2': number2,
        'operation': operation,
        'correctAnswer': correctAnswer
      };
}
