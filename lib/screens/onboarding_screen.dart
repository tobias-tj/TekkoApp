import 'package:flutter/material.dart';
import 'package:tekko/screens/accounts/create_account_screen.dart';
import 'package:tekko/screens/home_screen.dart';
import 'package:tekko/styles/app_colors.dart';
import 'onboarding_step.dart'; // Asegúrate de importar el componente de OnboardingStep.

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  final List<String> _tutorialTexts = [
    "Tekko quiere acompañarte",
    "Tekko está feliz por conocerte"
  ];

  final List<String> _buttonText = ["ADOPTAR", "EMPEZAR"];

  final List<String> _lottieAnim = [
    "assets/animations/boxDog11.json",
    "assets/animations/happyDogIntro.json"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: 2,
        itemBuilder: (context, index) {
          return OnboardingStep(
            imagePath: 'assets/images/bgIntro.png',
            backgroundColor: AppColors.softCream,
            text: _tutorialTexts[index],
            textButton: _buttonText[index],
            lottieAnimation: _lottieAnim[index],
            onNext: () {
              if (index == 1) {
                // Si es el último paso, navegar a la CreateAccount
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const CreateAccountScreen()),
                );
              } else {
                // Si no es el último paso, avanzar al siguiente
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          );
        },
      ),
    );
  }
}
