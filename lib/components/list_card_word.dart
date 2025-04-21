import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:tekko/features/services/favorites_services.dart';
import 'package:tekko/styles/app_colors.dart';

class ListCardWord extends StatefulWidget {
  final int wordId;
  final String imagePath;
  final String title;
  final String soundPath;
  final bool isFavorite;

  const ListCardWord(
      {super.key,
      required this.wordId,
      required this.imagePath,
      required this.title,
      required this.soundPath,
      required this.isFavorite});

  @override
  State<ListCardWord> createState() => _ListCardWordState();
}

class _ListCardWordState extends State<ListCardWord> {
  late bool _isFavorite;
  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  @override
  void didUpdateWidget(ListCardWord oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Sincronizamos con el padre si cambia
    if (widget.isFavorite != _isFavorite) {
      setState(() {
        _isFavorite = widget.isFavorite;
      });
    }
  }

  void _toggleFavorite() async {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    // Luego actualizamos el almacenamiento
    if (_isFavorite) {
      await FavoritesService.addFavorite(widget.wordId);
    } else {
      await FavoritesService.removeFavorite(widget.wordId);
    }
  }

  void _playSound() {
    final player = AudioPlayer();
    player.play(
        AssetSource(widget.soundPath)); // Reproduce el sonido desde assets
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _playSound(),
      child: Card(
        color: AppColors.softCream,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      widget.imagePath,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  IconButton(
                    onPressed: _toggleFavorite,
                    icon: Icon(
                      _isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: widget.isFavorite
                          ? Colors.red
                          : AppColors.chocolateNewDark,
                      size: 35,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.chocolateNewDark),
                  ),
                  const SizedBox(width: 7),
                  Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white, // Color del fondo circular
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/images/iconSound.png',
                        fit: BoxFit.cover,
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
