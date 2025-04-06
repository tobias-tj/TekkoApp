import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tekko/styles/app_colors.dart';
import 'package:flutter/widgets.dart';

class NumberGame extends StatefulWidget {
  const NumberGame({super.key});

  @override
  State<NumberGame> createState() => _NumberGameState();
}

class _NumberGameState extends State<NumberGame> {
  int number1 = 0;
  int number2 = 0;
  late int correctAnswer;
  List<int> options = [];

  final Random _random = Random();
  String feedbackMessage = '';
  Color feedbackColor = Colors.transparent;

  @override
  void initState() {
    super.initState();
    generateQuestion();
  }

  void generateQuestion() {
    number1 = _random.nextInt(5) + 1;
    number2 = _random.nextInt(5) + 1;
    correctAnswer = number1 + number2;

    options = [correctAnswer];
    while (options.length < 3) {
      int option = correctAnswer + _random.nextInt(5) - 2;
      if (option > 0 && !options.contains(option)) {
        options.add(option);
      }
    }

    options.shuffle();
    feedbackMessage = '';
    feedbackColor = Colors.transparent;
  }

  void checkAnswer(int selected) {
    if (selected == correctAnswer) {
      setState(() {
        feedbackMessage = '¡Muy bien! 🎉';
        feedbackColor = Colors.greenAccent.shade100;
      });
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          generateQuestion();
        });
      });
    } else {
      setState(() {
        feedbackMessage = 'Intenta otra vez 😊';
        feedbackColor = Colors.redAccent.shade100;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // ocupa todo el ancho disponible
      height: double.infinity,
      color: AppColors.softCream,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Text(
              '¿Cuánto es?',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            margin:
                const EdgeInsets.symmetric(horizontal: 16), // margen opcional
            decoration: BoxDecoration(
              color: AppColors.cardMaskSoft,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 5)
              ],
            ),
            child: Text(
              '$number1 + $number2 = ?',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: options.map((option) {
                return ElevatedButton(
                  onPressed: () => checkAnswer(option),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.chocolateBg,
                    minimumSize: const Size(100, 100),
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    option.toString(),
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 30),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: feedbackColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              feedbackMessage,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
