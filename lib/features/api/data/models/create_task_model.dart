class CreateTaskModel {
  final int parentId;
  final int childrenId;
  final int number1;
  final int number2;
  final String operation;
  final int correctAnswer;

  CreateTaskModel(
      {required this.parentId,
      required this.childrenId,
      required this.number1,
      required this.number2,
      required this.operation,
      required this.correctAnswer});

  Map<String, dynamic> toJson() => {
        'parentId': parentId,
        'childrenId': childrenId,
        'number1': number1,
        'number2': number2,
        'operation': operation,
        'correctAnswer': correctAnswer
      };
}
