import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class ButtonWelcome extends StatelessWidget {
  final String textButton;
  final VoidCallback onPressed;

  const ButtonWelcome(
      {super.key, required this.textButton, required this.onPressed});

  void _handleTap() async {
    // Verifica si el dispositivo puede vibrar
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 100); // Vibración de 100ms
    }
    onPressed(); // Llama a la función original del botón
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/buttonWelcome.png"),
          fit: BoxFit.fill,
        )),
        child: Center(
          child: Text(
            textButton,
            style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
                decoration: TextDecoration.none,
                shadows: [
                  Shadow(
                      offset: Offset(2, 2),
                      blurRadius: 3,
                      color: Colors.black26)
                ]),
          ),
        ),
      ),
    );
  }
}
