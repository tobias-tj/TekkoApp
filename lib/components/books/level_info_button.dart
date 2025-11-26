import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:tekko/styles/app_colors.dart';

class LevelInfoButton extends StatelessWidget {
  final String btnTitle;

  const LevelInfoButton({
    super.key,
    required this.btnTitle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showLevelInfoModal(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.chocolateDark.withOpacity(0.95),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            // const HugeIcon(
            //   icon: HugeIcons.strokeRoundedInformationDiamond,
            //   size: 18,
            //   color: Colors.white,
            // ),
            Image.asset("assets/images/importantText.png",
                width: 35, height: 35),
            const SizedBox(width: 8),
            Text(
              btnTitle,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLevelInfoModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: FadeInDown(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.cardBackgroundSoft,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const HugeIcon(
                    size: 50,
                    icon: HugeIcons.strokeRoundedAward01,
                    color: AppColors.chocolateNewDark,
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    "¿Cómo subir de nivel?",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.chocolateNewDark,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    "Para subir de nivel, pedile a tus padres que te asignen "
                    "tareas o actividades. Cuando las completes, ganarás puntos "
                    "de experiencia y podrás desbloquear libros nuevos.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.chocolateNewDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                      ),
                      child: const Text(
                        "Entendido",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
