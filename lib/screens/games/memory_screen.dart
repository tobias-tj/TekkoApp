import 'package:flutter/material.dart';
import 'package:tekko/screens/games/emoji_memory_game.dart';
import 'package:go_router/go_router.dart';

class MemoryScreen extends StatelessWidget {
  const MemoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(child: EmojiMemoryGame()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushReplacement('/home');
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.home),
      ),
    );
  }
}
