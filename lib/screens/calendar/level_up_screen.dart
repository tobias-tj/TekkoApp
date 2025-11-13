import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tekko/components/button_intro.dart';
import 'package:tekko/styles/app_colors.dart';

class LevelUpScreen extends StatefulWidget {
  final int newLevel;

  const LevelUpScreen({super.key, required this.newLevel});

  @override
  State<LevelUpScreen> createState() => _LevelUpScreenState();
}

class _LevelUpScreenState extends State<LevelUpScreen>
    with SingleTickerProviderStateMixin {
  late final ConfettiController _confettiController;
  late final AudioPlayer _audioPlayer;
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();

    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));

    _audioPlayer = AudioPlayer();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      _confettiController.play();
      _animController.forward();
      _playSound();
    });
  }

  Future<void> _playSound() async {
    try {
      await _audioPlayer.play(AssetSource('sounds/nivel/dogSound.mp3'));
    } catch (e) {
      debugPrint("Error reproduciendo sonido: $e");
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _audioPlayer.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: Stack(
        alignment: Alignment.center,
        children: [
          /// 🎉 Confetti
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            emissionFrequency: 0.05,
            numberOfParticles: 25,
            maxBlastForce: 20,
            minBlastForce: 8,
            gravity: 0.2,
            colors: const [
              Colors.amber,
              Colors.orange,
              Colors.deepPurple,
              Colors.pinkAccent,
              Colors.blueAccent,
            ],
            createParticlePath: _drawStar,
          ),

          /// 🧁 Contenido principal con animación
          ScaleTransition(
            scale: CurvedAnimation(
              parent: _animController,
              curve: Curves.elasticOut,
            ),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                width: size.width * 0.8,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "¡Felicidades!",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppColors.chocolateNewDark,
                      ),
                    ),
                    const SizedBox(height: 15),

                    /// 🐾 Animación principal
                    Lottie.asset(
                      'assets/animations/levelUp.json',
                      width: 160,
                      height: 160,
                      repeat: false,
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

                    Text(
                      "Nivel ${widget.newLevel}",
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: AppColors.chocolateNewDark,
                      ),
                    ),
                    const SizedBox(height: 20),

                    LinearProgressIndicator(
                      value: 1.0,
                      backgroundColor:
                          AppColors.chocolateNewDark.withOpacity(0.3),
                      color: AppColors.chocolateNewDark,
                      minHeight: 10,
                    ),
                    const SizedBox(height: 25),

                    const Text(
                      "🐶 ¡Guau! ¡Eres increíble!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.chocolateNewDark,
                      ),
                    ),
                    const SizedBox(height: 25),

                    ButtonIntro(
                      onNext: () {
                        Navigator.pop(context);
                      },
                      textButton: "Entendido",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🌟 Forma personalizada para las partículas del confeti
  Path _drawStar(Size size) {
    // Dibuja una estrella (más divertido que simples círculos)
    double degToRad(double deg) => deg * (pi / 180.0);
    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final path = Path();
    final angle = (2 * pi) / numberOfPoints;

    Offset center = Offset(halfWidth, halfWidth);

    for (int i = 0; i <= numberOfPoints; i++) {
      double x =
          center.dx + externalRadius * cos(i * angle - pi / 2); // punto externo
      double y =
          center.dy + externalRadius * sin(i * angle - pi / 2); // punto externo
      path.lineTo(x, y);

      x = center.dx +
          internalRadius * cos(i * angle + angle / 2 - pi / 2); // interno
      y = center.dy +
          internalRadius * sin(i * angle + angle / 2 - pi / 2); // interno
      path.lineTo(x, y);
    }

    path.close();
    return path;
  }
}
