import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tekko/components/button_intro.dart';
import 'package:tekko/styles/app_colors.dart';

class LevelUpScreen extends StatelessWidget {
  const LevelUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.softCream,
            borderRadius: BorderRadius.circular(16),
          ),
          width: size.width * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Resumen Hoy",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.chocolateNewDark,
                ),
              ),
              const SizedBox(height: 20),
              Lottie.asset(
                'assets/animations/levelUp.json',
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 20),
              const Text(
                "¡Has alcanzado!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.chocolateNewDark,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Nivel 2",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.chocolateNewDark,
                ),
              ),
              const SizedBox(height: 20),
              LinearProgressIndicator(
                value: 1.0,
                backgroundColor: AppColors.chocolateNewDark.withOpacity(0.3),
                color: AppColors.chocolateNewDark,
                minHeight: 10,
              ),
              const SizedBox(height: 20),
              const Text(
                "¡Felicitaciones, eres increíble!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.chocolateNewDark,
                ),
              ),
              const SizedBox(height: 20),
              ButtonIntro(
                  onNext: () => {Navigator.pop(context)},
                  textButton: "Entendido"),
            ],
          ),
        ),
      ),
    );
  }
}
