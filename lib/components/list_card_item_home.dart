import 'package:flutter/material.dart';
import 'package:tekko/styles/app_colors.dart';

class ListCardItemHome extends StatelessWidget {
  final String imagePath;
  final String title;
  const ListCardItemHome(
      {super.key, required this.imagePath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.chocolateDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imagePath,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            Text(title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.softCream,
                ))
          ],
        ),
      ),
    );
  }
}
