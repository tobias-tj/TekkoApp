import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tekko/screens/games/emoji_memory_state.dart';

class EmojiMemoryGame extends HookWidget {
  const EmojiMemoryGame({super.key});

  @override
  Widget build(BuildContext context) {
    final state = useState(EmojiMemoryState.initial);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Juego de Memoria 🧠'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => state.value = EmojiMemoryState.initial,
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Text(
            'Puntos: ${state.value.score}',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemCount: state.value.cardLayout.length,
              itemBuilder: (context, index) {
                final card = state.value.cardLayout[index];
                final isFlipped = state.value.selectedCards.contains(card) ||
                    state.value.completedCards.contains(card);

                return GestureDetector(
                  onTap: () async {
                    if (!isFlipped && state.value.canSelect) {
                      state.value = state.value.selectCard(card);

                      if (state.value.selectedCards.length == 2) {
                        await Future.delayed(const Duration(milliseconds: 800));
                        state.value = state.value.clearSelectionAndCheckMatch();
                      }
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: isFlipped ? Colors.white : Colors.brown[200],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.brown, width: 2),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      isFlipped ? card.emoji : '❓',
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
