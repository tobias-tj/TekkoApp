import 'package:flutter/material.dart';
import 'package:tekko/components/books/level_info_button.dart';
import 'package:tekko/styles/app_colors.dart';

class BookKidHeader extends StatelessWidget {
  final int level;
  final AnimationController sparkleController;
  const BookKidHeader(
      {super.key, required this.level, required this.sparkleController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6),
      child: Row(
        children: [
          // Sparkly star + title
          ScaleTransition(
            scale: Tween(begin: 0.95, end: 1.05).animate(CurvedAnimation(
              parent: sparkleController,
              curve: Curves.easeInOut,
            )),
            child: Image.asset(
              "assets/images/activities/readIcon.png",
              width: 40,
              height: 40,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Biblioteca',
                    style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 26,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('Explora cuentos y actividades',
                    style: TextStyle(color: AppColors.softCreamDark)),
              ],
            ),
          ),

          // Level pill
          LevelInfoButton(btnTitle: "Nivel $level"),
        ],
      ),
    );
  }
}
