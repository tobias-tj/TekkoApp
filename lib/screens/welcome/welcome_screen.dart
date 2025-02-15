import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:tekko/components/button_welcome.dart';
import 'package:tekko/styles/app_colors.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int currentStep = 0; // Estado para manejar los pasos

  // Listas con la información dinámica de cada paso
  final List<String> titles = [
    "Tekko quiere acompañarte",
    "Tekko esta feliz por conocerte"
  ];

  final List<String> buttonTexts = ["ADOPTAR", "¡VAMOS!"];

  final List<String> animations = [
    "assets/animations/boxDog.json",
    "assets/animations/astronautDog.json"
  ];

  // Método para manejar la transición entre pasos
  void _nextStep(BuildContext context) {
    if (currentStep < titles.length - 1) {
      setState(() {
        currentStep++;
      });
    } else {
      context.pushReplacement('/create-account');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final waveHeight = size.height * 0.3;

    return Stack(
      children: [
        // Fondo color softCream
        Container(
          width: size.width,
          height: size.height,
          color: AppColors.softCream,
        ),

        Positioned(
          top: size.height * 0.2,
          left: 0,
          right: 0,
          child: const CustomBackground(),
        ),

        Positioned(
          top: size.height * 0.1,
          left: 0,
          right: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                'Bienvenido a',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: AppColors.chocolateNewDark,
                    decoration: TextDecoration.none),
              ),
              Text(
                'TEKKO',
                style: TextStyle(
                    fontSize: 49,
                    fontWeight: FontWeight.bold,
                    color: AppColors.chocolateNewDark,
                    decoration: TextDecoration.none),
              ),
            ],
          ),
        ),

        Positioned(
          top: waveHeight,
          left: 0,
          right: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Animación Lottie que cambia según el paso
              Lottie.asset(
                animations[currentStep],
                repeat: true,
                width: 325,
                height: 325,
              ),
              const SizedBox(height: 50),

              // Texto dinámico
              Text(
                titles[currentStep],
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
              const SizedBox(height: 30),

              // Botón de siguiente paso
              Padding(
                padding: const EdgeInsets.all(10),
                child: ButtonWelcome(
                  textButton: buttonTexts[currentStep],
                  onPressed: () => _nextStep(context), // Pasar función al botón
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomBackground extends StatelessWidget {
  const CustomBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Image.asset(
      'assets/images/bottomBackground.png',
      width: size.width,
      height: size.height,
      fit: BoxFit.cover,
    );
  }
}
