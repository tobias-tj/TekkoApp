import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tekko/styles/app_colors.dart';

class DialogHome extends StatelessWidget {
  const DialogHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.softCreamDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 4,
      child: Row(
        children: [
          // Animacion de Lottie
          Lottie.asset(
            "assets/animations/dogHome1.json",
            repeat: true,
            width: 150,
            height: 150,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Trabaja con Tekko",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                    onPressed: () {
                      print("Boton Hablemos presionado");
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                    child: const Text(
                      "Hablemos",
                      style: TextStyle(color: AppColors.softCreamDark),
                    ))
              ],
            ),
          ))
        ],
      ),
    );
  }
}
