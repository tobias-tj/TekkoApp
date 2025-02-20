import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tekko/components/agend_list.dart';
import 'package:tekko/components/top_custom_calendar.dart';
import 'package:tekko/styles/app_colors.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  bool showWinnerSummary = false;
  bool showLevelUpSummary = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: AppColors.softCream,
        body: Stack(children: [
          Container(
            width: size.width,
            height: size.height,
            color: AppColors.softCream,
          ),
          Column(
            children: [
              TopCustomCalendar(),
              const SizedBox(height: 2),
              const AgendList(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        showWinnerSummary =
                            true; // Muestra el resumen del ganador
                      });
                    },
                    child: const Text("Animación Ganador"),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        showLevelUpSummary =
                            true; // Muestra el resumen de subir de nivel
                      });
                    },
                    child: const Text("Subir de Nivel"),
                  ),
                ],
              )
            ],
          ),
          // Superposición del resumen del ganador
          if (showWinnerSummary)
            _buildOverlay(
              child: _buildWinnerSummary(
                size: size,
                onClose: () {
                  setState(() {
                    showWinnerSummary = false;
                  });
                },
              ),
              onClose: () {
                setState(() {
                  showWinnerSummary = false;
                });
              },
            ),

          // Superposición del resumen de subir de nivel
          if (showLevelUpSummary)
            _buildOverlay(
              child: _buildLevelUpSummary(
                size: size,
                onClose: () {
                  setState(() {
                    showLevelUpSummary = false;
                  });
                },
              ),
              onClose: () {
                setState(() {
                  showLevelUpSummary = false;
                });
              },
            ),
        ]));
  }
}

// Widget para construir el fondo opaco y el contenido superpuesto
Widget _buildOverlay({required Widget child, required VoidCallback onClose}) {
  return Stack(
    children: [
      // Fondo negro opacado
      GestureDetector(
        onTap: onClose,
        child: Container(
          color: Colors.black.withOpacity(0.7),
          width: double.infinity,
          height: double.infinity,
        ),
      ),

      // Contenido superpuesto
      Center(
        child: child,
      ),
    ],
  );
}

// Widget para el resumen del ganador
Widget _buildWinnerSummary(
    {required Size size, required VoidCallback onClose}) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: AppColors.softCream,
      borderRadius: BorderRadius.circular(16),
    ),
    width: size.width * 0.8,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Resumen Hoy",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.chocolateNewDark,
          ),
        ),
        const SizedBox(height: 20),
        Lottie.asset(
          'assets/animations/starWining.json',
          width: 150,
          height: 150,
        ),
        const SizedBox(height: 20),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "30 XP",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.chocolateNewDark,
              ),
            ),
            Text(
              "+ 10 XP",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.chocolateNewDark,
              ),
            ),
            Divider(color: AppColors.chocolateNewDark),
            Text(
              "40 XP",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.chocolateNewDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          "¡Felicitaciones, eres increíble!",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.chocolateNewDark,
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: onClose,
          child: const Text("Cerrar"),
        ),
      ],
    ),
  );
}

// Widget para el resumen de subir de nivel
Widget _buildLevelUpSummary(
    {required Size size, required VoidCallback onClose}) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: AppColors.softCream,
      borderRadius: BorderRadius.circular(16),
    ),
    width: size.width * 0.8,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Resumen Hoy",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.chocolateNewDark,
          ),
        ),
        const SizedBox(height: 20),
        Lottie.asset(
          'assets/animations/levelUp.json',
          width: 150,
          height: 150,
        ),
        const SizedBox(height: 20),
        const Text(
          "¡Has alcanzado!",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.chocolateNewDark,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "Nivel 2",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.chocolateNewDark,
          ),
        ),
        const SizedBox(height: 20),
        LinearProgressIndicator(
          value: 1.0,
          backgroundColor: AppColors.chocolateNewDark.withOpacity(0.3),
          color: AppColors.chocolateNewDark,
          minHeight: 10,
        ),
        const SizedBox(height: 20),
        const Text(
          "¡Felicitaciones, eres increíble!",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.chocolateNewDark,
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: onClose,
          child: const Text("Cerrar"),
        ),
      ],
    ),
  );
}
