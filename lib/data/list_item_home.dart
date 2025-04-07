class Item {
  final int id;
  final String imagePath;
  final String title;

  const Item({required this.id, required this.imagePath, required this.title});
}

class ItemData {
  static const List<Item> itemHome = [
    Item(
        id: 1,
        imagePath: 'assets/images/conversationIcon.png',
        title: 'Conversacion'),
    Item(id: 2, imagePath: 'assets/images/cloth-hd.png', title: 'Ropas'),
    Item(id: 3, imagePath: 'assets/images/family-hd.png', title: 'Familia'),
    Item(id: 4, imagePath: 'assets/images/food-hd.png', title: 'Alimentos'),
    Item(id: 5, imagePath: 'assets/images/game-hd.png', title: 'Juegos'),
    Item(id: 6, imagePath: 'assets/images/animals-hd.png', title: 'Animales'),
  ];

  static List<Item> getAll() => itemHome;
}
