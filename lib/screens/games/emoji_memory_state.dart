import 'package:tekko/screens/games/emoji_card.dart';

class EmojiMemoryState {
  final List<EmojiCard> cardLayout;
  final List<EmojiCard> selectedCards;
  final List<EmojiCard> completedCards;
  final int attempts;
  final int score;

  const EmojiMemoryState({
    required this.cardLayout,
    required this.selectedCards,
    required this.completedCards,
    required this.attempts,
    required this.score,
  });

  bool get canSelect => selectedCards.length < 2;

  EmojiMemoryState selectCard(EmojiCard card) {
    return EmojiMemoryState(
      cardLayout: cardLayout,
      selectedCards: [...selectedCards, card],
      completedCards: completedCards,
      attempts: attempts,
      score: score,
    );
  }

  EmojiMemoryState clearSelectionAndCheckMatch() {
    final match = selectedCards.length == 2 &&
        selectedCards[0].emoji == selectedCards[1].emoji;

    return EmojiMemoryState(
      cardLayout: cardLayout,
      selectedCards: [],
      completedCards: [
        ...completedCards,
        if (match) ...selectedCards,
      ],
      attempts: attempts + 1,
      score: score + (match ? 10 : 0), // 🎯 Aumentamos puntos si aciertan
    );
  }

  static EmojiMemoryState get initial {
    final emojis = ['🍎', '🚗', '🐶', '🎈', '🍕', '🌟', '🦋', '⚽️'];
    final allCards = [
      for (int i = 0; i < emojis.length; i++) ...[
        EmojiCard(id: 'emoji_${i}_a', emoji: emojis[i]),
        EmojiCard(id: 'emoji_${i}_b', emoji: emojis[i]),
      ]
    ]..shuffle();

    return EmojiMemoryState(
      cardLayout: allCards,
      selectedCards: [],
      completedCards: [],
      attempts: 0,
      score: 0,
    );
  }
}
