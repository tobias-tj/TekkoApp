import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:tekko/styles/app_colors.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 5000), () {
      context.pushReplacement('/maps');
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
                "assets/animations/dogChill.json",
                repeat: true,
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
              Lottie.asset(
                "assets/animations/loadingFrame.json",
                repeat: true,
                width: 100,
                height: 100,
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
      'assets/images/bgsplash.png',
      width: size.width,
      height: size.height,
      fit: BoxFit.cover,
    );
  }
}
