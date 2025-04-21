import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:tekko/data/list_item_word.dart';
import 'package:tekko/styles/app_colors.dart';
import 'package:tekko/features/services/favorites_services.dart';

class ItemWordCard extends StatefulWidget {
  final ItemWord item;
  final VoidCallback onFavoriteRemoved;

  const ItemWordCard(
      {super.key, required this.item, required this.onFavoriteRemoved});

  @override
  State<ItemWordCard> createState() => _ItemWordCardState();
}

class _ItemWordCardState extends State<ItemWordCard> {
  void _toggleRemoveFavorite() async {
    await FavoritesService.removeFavorite(widget.item.idWord);
    widget.onFavoriteRemoved();
  }

  void _playSound() {
    final player = AudioPlayer();
    player.play(
        AssetSource(widget.item.soundPath)); // Reproduce el sonido desde assets
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _playSound(),
      child: Card(
        color: AppColors.cardBackgroundSoft,
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
              padding: EdgeInsets.all(13),
              child: Column(
                children: [
                  // Imagen en el centro
                  Image.asset(
                    widget.item.imagePath,
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(height: 8.0),
                  // Texto acompañado de una imagen de volumen
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.item.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
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
              onPressed: () => _toggleRemoveFavorite(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.chocolateNewDark, // Color del botón
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50.0, vertical: 8.0),
              ),
              child: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
