import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';
import 'package:tekko/styles/app_colors.dart';

class SplashScreen extends StatefulWidget {
  final String? mode; // Parámetro opcional para el modo

  const SplashScreen({super.key, this.mode});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 4000), () {
      if (widget.mode == 'parent') {
        // Redirigir al AdminHomeScreen si el modo es "parent"
        context.pushReplacement('/adminHome');
      } else {
        // Redirigir al WelcomeScreen en el flujo normal
        context.pushReplacement('/welcome');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final waveHeight = size.height * 0.4; // Calcula la altura del límite

    return Stack(
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
                    decoration: TextDecoration.none),
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
      'assets/images/bgsplash.png', // Asegúrate de colocar la ruta correcta de la imagen
      width: size.width,
      height: size.height,
      fit: BoxFit.cover, // Asegura que la imagen se ajuste bien a la pantalla
    );
  }
}
