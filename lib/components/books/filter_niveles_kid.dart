import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:tekko/styles/app_colors.dart';

class FilterNivelesKid extends StatelessWidget {
  final String label;
  final int nivelFiltro;
  final int currentLevel;
  final int selectedLevel;

  final VoidCallback? onLockedTap;
  final VoidCallback onSelected;

  const FilterNivelesKid({
    super.key,
    required this.label,
    required this.nivelFiltro,
    required this.currentLevel,
    required this.selectedLevel,
    required this.onSelected,
    this.onLockedTap,
  });

  @override
  Widget build(BuildContext context) {
    final isUnlocked = currentLevel >= nivelFiltro;
    final isSelected = selectedLevel == nivelFiltro;

    return InkWell(
      onTap: isUnlocked ? onSelected : onLockedTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        margin: const EdgeInsets.only(right: 12, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: !isUnlocked
              ? Colors.grey.shade400
              : isSelected
                  ? AppColors.chocolateNewDark
                  : AppColors.textColor,
          boxShadow: [
            if (isSelected)
              const BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 3),
              )
          ],
        ),
        child: Row(
          children: [
            HugeIcon(
              icon: isUnlocked
                  ? HugeIcons.strokeRoundedStar
                  : HugeIcons.strokeRoundedSquareLockPassword,
              size: 20,
              color: isSelected ? Colors.white : Colors.black87,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
