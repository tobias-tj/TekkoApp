import 'package:flutter/material.dart';
import 'package:tekko/components/dialog_home.dart';
import 'package:tekko/styles/app_colors.dart';

class TopCustomBackground extends StatelessWidget {
  const TopCustomBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.4,
      child: Stack(
        children: [
          // Fondo recto
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: size.height * 0.2, // Altura del fondo
              color: AppColors.chocolateNewDark, // Color del fondo
            ),
          ),

          // Contenido (izquierda, centro, derecha)
          Positioned(
            top: 50, // Espacio desde la parte superior
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Distribuye el espacio
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Izquierda: Fondo circular con un icono
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white, // Color del fondo circular
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/images/iconProfile.png',
                        fit: BoxFit.cover,
                      )),
                ),

                // Centro: "Nivel 1", barra de progreso y "Nivel De Progreso"
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Nivel 1",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.softCreamDark,
                      ),
                    ),
                    const SizedBox(height: 8), // Espaciado
                    Container(
                      width: 150, // Ancho de la barra de progreso
                      height: 10, // Alto de la barra de progreso
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: 0.5, // Progreso actual de la barra
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.chocolateDark,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8), // Espaciado
                    const Text(
                      "Nivel De Progreso",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.softCreamDark,
                      ),
                    ),
                  ],
                ),

                // Derecha: Icono de estrella y "30XP"
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/iconStar.png',
                          width: 38, height: 30, fit: BoxFit.cover),
                      const SizedBox(height: 4), // Espaciado
                      const Text(
                        "30XP",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.softCreamDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // DialogHome (se mantiene en su posición original)
          const Positioned(
            top: 140, // Ajusta la posición según sea necesario
            left: 0,
            right: 0,
            child: DialogHome(),
          ),
        ],
      ),
    );
  }
}
