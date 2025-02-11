import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:go_router/go_router.dart';
import 'package:tekko/styles/app_colors.dart';
import 'drawing_game.dart';

class DrawingScreen extends StatefulWidget {
  const DrawingScreen({super.key});

  @override
  _DrawingScreenState createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  final DrawingGame _game = DrawingGame();

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
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  heroTag: 'color-back',
                  child: const Icon(
                    Icons.power_settings_new_rounded,
                    color: AppColors.chocolateNewDark,
                  ),
                  onPressed: () => context.pushReplacement('/home'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
