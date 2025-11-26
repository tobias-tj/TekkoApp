import 'package:flutter/material.dart';
import 'package:tekko/styles/app_colors.dart';

class FilterNivelesParent extends StatelessWidget {
  final String label;
  final int nivelFiltro;
  final int currentLevel;
  final int selectedLevel;

  final VoidCallback? onLockedTap;
  final VoidCallback onSelected;

  const FilterNivelesParent({
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
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: isUnlocked
              ? (isSelected ? AppColors.chocolateNewDark : Colors.white)
              : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isUnlocked
                ? (isSelected
                    ? AppColors.chocolateNewDark
                    : Colors.grey.shade400)
                : Colors.grey.shade400,
          ),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color: isUnlocked
                    ? (isSelected ? Colors.white : Colors.grey.shade700)
                    : Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),

            // Icono candado si está bloqueado
            if (!isUnlocked) ...[
              const SizedBox(width: 8),
              const Icon(Icons.lock, size: 18, color: Colors.grey),
            ]
          ],
        ),
      ),
    );
  }
}
