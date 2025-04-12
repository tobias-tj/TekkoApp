import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:tekko/styles/app_colors.dart';

class DialogHome extends StatelessWidget {
  const DialogHome({
    super.key,
  });

  void _playSound() {
    final player = AudioPlayer();
    player.play(AssetSource('sounds/nivel/dogSound.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.softCreamDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 4,
      child: Row(
        children: [
          // Animacion de Lottie
          GestureDetector(
            onTap: () => _playSound(),
            child: Lottie.asset(
              "assets/animations/dogHome1.json",
              repeat: true,
              width: 125,
              height: 125,
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Trabaja con Tekko",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                    onPressed: () => context.push('/activity'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                    child: const Text(
                      "Actividades",
                      style: TextStyle(color: AppColors.softCreamDark),
                    ))
              ],
            ),
          ))
        ],
      ),
    );
  }
}
