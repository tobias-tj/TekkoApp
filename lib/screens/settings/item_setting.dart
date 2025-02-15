import 'package:flutter/material.dart';
import 'package:tekko/styles/app_colors.dart';

class ItemSetting extends StatelessWidget {
  final String title;
  const ItemSetting({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(14),
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
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.chocolateNewDark,
            )
          ],
        ),
      ),
    );
  }
}
