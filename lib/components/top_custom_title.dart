import 'package:flutter/material.dart';
import 'package:tekko/styles/app_colors.dart';

class TopCustomTitle extends StatelessWidget {
  final String title;
  const TopCustomTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.15, // Ajuste de altura
      child: Stack(
        children: [
          // Fondo
          Positioned.fill(
            child: Container(
              color: AppColors.chocolateNewDark,
            ),
          ),

          // Contenido
          Positioned(
            top: 50, // Espacio desde arriba
            left: 0,
            right: 0,
            child: Row(
              children: [
                // Botón de retroceso
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new,
                      color: AppColors.softCreamDark),
                  onPressed: () => Navigator.of(context).pop(),
                ),

                // Espacio flexible para centrar el título
                Expanded(
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.softCreamDark,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                const SizedBox(
                    width: 48), // Tamaño aproximado del botón de retroceso
              ],
            ),
          ),
        ],
      ),
    );
  }
}
