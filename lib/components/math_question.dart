import 'dart:math';

class MathQuestion {
  final String question;
  final int correctAnswer;
  final List<int> incorrectAnswers;

  MathQuestion(this.question, this.correctAnswer, this.incorrectAnswers);
}

MathQuestion generateMathQuestion() {
  final random = Random();
  final num1 = random.nextInt(10) + 1; // Números entre 1 y 10
  final num2 = random.nextInt(10) + 1;
  final operation = random.nextInt(3); // 0: suma, 1: resta, 2: multiplicación

  int correctAnswer;
  String question;

  switch (operation) {
    case 0:
      correctAnswer = num1 + num2;
      question = '¿Cuánto es $num1 + $num2?';
      break;
    case 1:
      correctAnswer = num1 - num2;
      question = '¿Cuánto es $num1 - $num2?';
      break;
    case 2:
      correctAnswer = num1 * num2;
      question = '¿Cuánto es $num1 x $num2?';
      break;
    default:
      correctAnswer = num1 + num2;
      question = '¿Cuánto es $num1 + $num2?';
  }

  // Generar respuestas incorrectas
  final incorrectAnswers = <int>[];
  while (incorrectAnswers.length < 2) {
    final incorrectAnswer =
        correctAnswer + random.nextInt(5) + 1; // Respuesta incorrecta aleatoria
    if (incorrectAnswer != correctAnswer &&
        !incorrectAnswers.contains(incorrectAnswer)) {
      incorrectAnswers.add(incorrectAnswer);
    }
  }

  return MathQuestion(question, correctAnswer, incorrectAnswers);
}
