import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:tekko/screens/onboarding_screen.dart';
import '../app.dart';
import 'package:tekko/styles/app_colors.dart'; // Asegúrate de importar tu archivo de colores

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final waveHeight = size.height * 0.4; // Calcula la altura del límite

    return FlutterSplashScreen(
      backgroundColor: Colors.transparent,
      duration: const Duration(milliseconds: 4000),
      splashScreenBody: Stack(
        children: [
          // Fondo color softCream
          Container(
            width: size.width,
            height: size.height,
            color: AppColors.softCream, // Aplica el color de fondo
          ),
          const CustomBackground(),
          Positioned(
            top: waveHeight,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset(
                  "assets/animations/dogsplash.json",
                  repeat: false,
                  width: 250,
                  height: 250,
                ),
                const SizedBox(height: 20),
                const Text(
                  'TEKKO',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: AppColors.softCreamDark,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      nextScreen: const OnboardingScreen(),
    );
  }
}

class CustomBackground extends StatelessWidget {
  const CustomBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Image.asset(
      'assets/images/bgsplash.png', // Asegúrate de colocar la ruta correcta de la imagen
      width: size.width,
      height: size.height,
      fit: BoxFit.cover, // Asegura que la imagen se ajuste bien a la pantalla
    );
  }
}
