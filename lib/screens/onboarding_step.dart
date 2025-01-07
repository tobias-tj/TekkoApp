import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tekko/components/button_intro.dart';

class OnboardingStep extends StatelessWidget {
  final String imagePath;
  final Color backgroundColor;
  final String text;
  final String textButton;
  final String lottieAnimation;
  final VoidCallback onNext;

  const OnboardingStep({
    super.key,
    required this.imagePath,
    required this.backgroundColor,
    required this.lottieAnimation,
    required this.text,
    required this.textButton,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: backgroundColor,
      child: Stack(
        children: [
          // Imagen de fondo
          Image.asset(
            imagePath,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          // Texto central
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  Lottie.asset(lottieAnimation,
                      repeat: true,
                      fit: BoxFit.contain,
                      width: 350,
                      height: 350),
                  const SizedBox(height: 20),
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // Botón de siguiente
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ButtonIntro(onNext: onNext, textButton: textButton),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
