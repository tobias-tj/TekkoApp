import 'package:flutter/material.dart';
import 'package:tekko/styles/app_colors.dart';

class BuildDialogInfoItem extends StatelessWidget {
  final String text;
  const BuildDialogInfoItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: AppColors.chocolateNewDark,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
