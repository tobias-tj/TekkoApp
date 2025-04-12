import 'package:flutter/material.dart';
import 'package:tekko/styles/app_colors.dart';

class ItemSetting extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const ItemSetting({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Material(
        color: Colors.transparent, // Para mantener el fondo
        child: InkWell(
          borderRadius: BorderRadius.circular(
              12), // Para que el ripple tenga bordes redondeados
          onTap: onTap,
          splashColor: AppColors.chocolateNewDark.withOpacity(0.2),
          highlightColor: AppColors.chocolateNewDark.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.chocolateNewDark,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.chocolateNewDark,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
