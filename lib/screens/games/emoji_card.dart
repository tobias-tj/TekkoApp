class EmojiCard {
  final String emoji;
  final String id;

  const EmojiCard({required this.emoji, required this.id});

  @override
  bool operator ==(Object other) => other is EmojiCard && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
