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
    Item(id: 2, imagePath: 'assets/images/ropIcon.png', title: 'Ropas'),
    Item(id: 3, imagePath: 'assets/images/familyIcon.png', title: 'Familia'),
    Item(id: 4, imagePath: 'assets/images/foodIcon.png', title: 'Alimentos'),
    Item(id: 5, imagePath: 'assets/images/gamesIcon.png', title: 'Juegos'),
    Item(id: 6, imagePath: 'assets/images/animalsIcon.png', title: 'Animales'),
  ];

  static List<Item> getAll() => itemHome;
}
