import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tekko/components/button_intro.dart';
import 'package:tekko/styles/app_colors.dart';

class WinnerScreen extends StatelessWidget {
  const WinnerScreen({super.key});

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
                'assets/animations/starWining.json',
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 20),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "30 XP",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.chocolateNewDark,
                    ),
                  ),
                  Text(
                    "+ 10 XP",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.chocolateNewDark,
                    ),
                  ),
                  Divider(color: AppColors.chocolateNewDark),
                  Text(
                    "40 XP",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.chocolateNewDark,
                    ),
                  ),
                ],
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
