import 'package:flutter/material.dart';
import 'package:tekko/data/list_item_word.dart';
import 'package:tekko/styles/app_colors.dart';

class ItemWordCard extends StatelessWidget {
  final ItemWord item;

  const ItemWordCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.cardBackgroundSoft, // Color del card (#C68133)
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), // Bordes redondeados
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Contenedor con borde redondeado y color más oscuro
          Container(
            decoration: BoxDecoration(
              color: AppColors.cardMaskSoft, // Color más oscuro
              borderRadius: BorderRadius.circular(12.0), // Bordes redondeados
            ),
            padding: EdgeInsets.all(18),
            child: Column(
              children: [
                // Imagen en el centro
                Image.asset(
                  item.imagePath,
                  width: 50,
                  height: 50,
                ),
                const SizedBox(height: 8.0),
                // Texto acompañado de una imagen de volumen
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 1.0),
                    Image.asset(
                      'assets/images/iconSound.png',
                      width: 20,
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Botón con ícono de corazón en el centro
          ElevatedButton(
            onPressed: () {
              // Lógica para manejar el favorito
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.chocolateNewDark, // Color del botón
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 8.0),
            ),
            child: const Icon(
              Icons.favorite_border,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
