import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lottie/lottie.dart';
import 'package:tekko/styles/app_colors.dart';

class AdminHelpScreen extends StatelessWidget {
  const AdminHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: AppColors.cardBackgroundSoft,
        body: Stack(children: [
          Container(
            width: size.width,
            height: size.height,
            color: AppColors.softCream,
          ),
          const CustomBackground(),
          Positioned(
              top: 70,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70.0),
                child: SizedBox(
                  height: 250,
                  child: Card(
                    color: const Color.fromARGB(96, 239, 195, 142),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            "assets/animations/dogHome1.json",
                            repeat: true,
                            width: 125,
                            height: 125,
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Text("TEKKO",
                              style: TextStyle(
                                  color: AppColors.textColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold)),
                          Text("Power By YvagaCore",
                              style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: 15,
                              )),
                          SizedBox(height: 12)
                        ]),
                  ),
                ),
              )),
          // Dentro del Stack de tu Scaffold, después del Positioned que ya tienes:
          Positioned(
            bottom: size.height * 0.3,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Text(
                  "¿Te gusta Tekko?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.chocolateNewDark,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Puedes apoyar el proyecto de manera voluntaria.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.chocolateNewDark,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors
                        .chocolateNewDark, // El color principal que uses
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 12),
                  ),
                  onPressed: () {
                    // Aquí podrías abrir un enlace o mostrar un diálogo informativo
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: AppColors.cardBackgroundSoft,
                        title: const Text("Donar a Tekko"),
                        content: const Text(
                          "Pronto habilitaremos la opción de donación para seguir mejorando Tekko. ¡Gracias por tu interés y apoyo!",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              "Cerrar",
                              style:
                                  TextStyle(color: AppColors.chocolateNewDark),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    width: 200,
                    child: Row(
                      children: [
                        HugeIcon(
                            icon: HugeIcons.strokeRoundedPayment01,
                            color: AppColors.textColor,
                            size: 25.0),
                        SizedBox(width: 12),
                        Text(
                          "Apoyar a Tekko",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}

class CustomBackground extends StatelessWidget {
  const CustomBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.6,
      child: Image.asset(
        'assets/images/topTitleAccount.png',
        width: size.width,
        height: size.height,
        fit: BoxFit.cover,
      ),
    );
  }
}
