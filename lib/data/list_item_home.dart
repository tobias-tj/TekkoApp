class Item {
  final int id;
  final String imagePath;
  final String title;
  final int level;

  const Item(
      {required this.id,
      required this.imagePath,
      required this.title,
      required this.level});
}

class ItemData {
  static const List<Item> itemHome = [
    Item(
        id: 1,
        imagePath: 'assets/images/conversationIcon.png',
        title: 'Frases',
        level: 1),
    Item(
        id: 2,
        imagePath: 'assets/images/cloth-hd.png',
        title: 'Ropas',
        level: 1),
    Item(
        id: 3,
        imagePath: 'assets/images/family-hd.png',
        title: 'Familia',
        level: 1),
    Item(
        id: 4,
        imagePath: 'assets/images/food-hd.png',
        title: 'Alimentos',
        level: 1),
    Item(
        id: 5,
        imagePath: 'assets/images/game-hd.png',
        title: 'Juegos',
        level: 1),
    Item(
        id: 6,
        imagePath: 'assets/images/animals-hd.png',
        title: 'Animales',
        level: 1),
    Item(
        id: 7,
        imagePath: 'assets/images/actionStart.png',
        title: 'Acciones \nDiarias',
        level: 2),
    Item(
        id: 8,
        imagePath: 'assets/images/feeling.png',
        title: 'Emociones',
        level: 2),
    Item(
        id: 9,
        imagePath: 'assets/images/school.png',
        title: 'Escuela',
        level: 2),
    Item(
        id: 10,
        imagePath: 'assets/images/transport.png',
        title: 'Transporte',
        level: 2),
    Item(
        id: 11,
        imagePath: 'assets/images/moreFood.png',
        title: 'Mas \ncomidas',
        level: 2),
    Item(
        id: 12,
        imagePath: 'assets/images/importantText.png',
        title: 'Frases \nútiles',
        level: 3),
    Item(
        id: 13,
        imagePath: 'assets/images/lugares.png',
        title: 'Lugares',
        level: 3),
    Item(
        id: 14, imagePath: 'assets/images/clima.png', title: 'Clima', level: 3),
    Item(
        id: 15,
        imagePath: 'assets/images/objetos.png',
        title: 'Objetos',
        level: 3),
    Item(
        id: 16,
        imagePath: 'assets/images/preguntas.png',
        title: 'Preguntas',
        level: 4),
    Item(
        id: 17,
        imagePath: 'assets/images/preferencias.png',
        title: 'Preferencias',
        level: 4),
    Item(
        id: 18,
        imagePath: 'assets/images/tiempo.png',
        title: 'Tiempo',
        level: 4),
    Item(
        id: 19,
        imagePath: 'assets/images/colores.png',
        title: 'Colores y \tamaños',
        level: 4),
    Item(
        id: 20,
        imagePath: 'assets/images/mensaje.png',
        title: 'Mensajes',
        level: 5),
    Item(
        id: 21,
        imagePath: 'assets/images/socializar.png',
        title: 'Socializar',
        level: 5),
    Item(
        id: 22,
        imagePath: 'assets/images/secuencia.png',
        title: 'Secuencia',
        level: 5),
    Item(
        id: 23,
        imagePath: 'assets/images/seguridad.png',
        title: 'Seguridad',
        level: 5),
  ];

  static List<Item> getAll() => itemHome;
}
