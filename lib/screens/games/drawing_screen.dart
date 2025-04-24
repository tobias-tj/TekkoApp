import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:gal/gal.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tekko/styles/app_colors.dart';
import 'drawing_game.dart';

class DrawingScreen extends StatefulWidget {
  const DrawingScreen({super.key});

  @override
  _DrawingScreenState createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  final DrawingGame _game = DrawingGame();

  Future<void> _saveDrawing() async {
    final imageBytes = await _game.exportImage();
    if (imageBytes == null) return;

    try {
      // 1. Crear un archivo temporal
      final tempDir = await getTemporaryDirectory();
      final file = File(
          '${tempDir.path}/dibujo_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(imageBytes);

      // 2. Guardar en la galería usando gal
      await Gal.putImage(file.path); // Método simplificado de gal

      // 3. Mostrar confirmación
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Dibujo guardado en la galería')),
      );

      // 4. Opcional: Eliminar el archivo temporal
      await file.delete();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dibujo Libre'),
        backgroundColor: AppColors.softCreamDark,
      ),
      body: Stack(
        children: [
          GameWidget(game: _game),
          Positioned(
            bottom: 20,
            left: 10,
            right: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      heroTag: 'color-red',
                      backgroundColor: Colors.red,
                      onPressed: () =>
                          setState(() => _game.changeColor(Colors.red)),
                    ),
                    FloatingActionButton(
                      heroTag: 'color-blue',
                      backgroundColor: Colors.blue,
                      onPressed: () =>
                          setState(() => _game.changeColor(Colors.blue)),
                    ),
                    FloatingActionButton(
                      heroTag: 'color-green',
                      backgroundColor: Colors.green,
                      onPressed: () =>
                          setState(() => _game.changeColor(Colors.green)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      backgroundColor: AppColors.softCreamDark,
                      heroTag: 'color-clear',
                      child: const Icon(
                        Icons.delete,
                        color: AppColors.chocolateNewDark,
                      ),
                      onPressed: () => setState(() => _game.clearCanvas()),
                    ),
                    FloatingActionButton(
                      backgroundColor: AppColors.softCreamDark,
                      heroTag: 'color-save',
                      onPressed: _saveDrawing,
                      child: const Icon(
                        Icons.save,
                        color: AppColors.chocolateNewDark,
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        context.pushReplacement('/home');
                      },
                      backgroundColor: AppColors.softCreamDark,
                      child: const Icon(
                        Icons.home,
                        color: AppColors.chocolateNewDark,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
