import 'package:flutter/material.dart';

class ButtonIntro extends StatelessWidget {
  const ButtonIntro({
    super.key,
    required this.onNext,
    required this.textButton,
  });

  final VoidCallback onNext;
  final String textButton;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onNext, // Acción al presionar
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "assets/images/buttonWelcome.png"), // Ruta de la imagen
            fit: BoxFit.fill, // Ajusta la imagen al tamaño del botón
          ),
        ),
        child: Center(
          child: Text(
            textButton,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Color del texto
              letterSpacing: 1.5, // Espaciado para hacerlo llamativo
              shadows: [
                Shadow(
                  offset: Offset(2, 2),
                  blurRadius: 3,
                  color: Colors.black26, // Sombra para resaltar el texto
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
