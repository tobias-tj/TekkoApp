import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:tekko/styles/app_colors.dart';

class ListCardWord extends StatelessWidget {
  final String imagePath;
  final String title;
  final String soundPath;

  const ListCardWord(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.soundPath});

  void _playSound() {
    final player = AudioPlayer();
    player.play(AssetSource(soundPath)); // Reproduce el sonido desde assets
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _playSound(),
      child: Card(
        color: AppColors.softCream,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      imagePath,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_border,
                        color: AppColors.chocolateNewDark,
                        size: 35,
                      ))
                ],
              ),
              const SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.chocolateNewDark),
                  ),
                  const SizedBox(width: 7),
                  Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white, // Color del fondo circular
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/images/iconSound.png',
                        fit: BoxFit.cover,
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
