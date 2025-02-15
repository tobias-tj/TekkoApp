class ItemWordType {
  final int id;
  final String typeWord;
  final List<ItemWord> listItemWord;

  const ItemWordType(
      {required this.id, required this.typeWord, required this.listItemWord});
}

class ItemWord {
  final int idWord;
  final String imagePath;
  final String title;
  final String soundPath;

  const ItemWord(
      {required this.idWord,
      required this.imagePath,
      required this.title,
      required this.soundPath});
}

class ItemWordData {
  static const List<ItemWordType> itemWord = [
    ItemWordType(id: 1, typeWord: 'Conversacion', listItemWord: [
      ItemWord(
          idWord: 1,
          imagePath: 'assets/images/words/conversacion/iconHello.png',
          title: 'Hola',
          soundPath: 'sounds/conversacion/soundHola.mp3'),
      ItemWord(
          idWord: 2,
          imagePath: 'assets/images/words/conversacion/iconAdios.png',
          title: 'Adiós',
          soundPath: 'sounds/conversacion/soundAdios.mp3'),
      ItemWord(
          idWord: 3,
          imagePath: 'assets/images/words/conversacion/iconMom.png',
          title: 'Mamá',
          soundPath: 'sounds/conversacion/soundMama.mp3'),
      ItemWord(
          idWord: 4,
          imagePath: 'assets/images/words/conversacion/iconDad.png',
          title: 'Papá',
          soundPath: 'sounds/conversacion/soundPapa.mp3'),
      ItemWord(
          idWord: 5,
          imagePath: 'assets/images/words/conversacion/iconWater.png',
          title: 'Agua',
          soundPath: 'sounds/conversacion/soundAgua.mp3'),
      ItemWord(
          idWord: 6,
          imagePath: 'assets/images/words/conversacion/iconFood.png',
          title: 'Comida',
          soundPath: 'sounds/conversacion/soundComida.mp3'),
      ItemWord(
          idWord: 7,
          imagePath: 'assets/images/words/conversacion/iconBath.png',
          title: 'Baño',
          soundPath: 'sounds/conversacion/soundBano.mp3'),
    ]),
    ItemWordType(id: 2, typeWord: 'Ropas', listItemWord: [
      ItemWord(
          idWord: 8,
          imagePath: 'assets/images/words/ropas/iconCamiseta.png',
          title: 'Camiseta',
          soundPath: 'sounds/ropas/soundCamiseta.mp3'),
      ItemWord(
          idWord: 9,
          imagePath: 'assets/images/words/ropas/iconPantalon.png',
          title: 'Pantalón',
          soundPath: 'sounds/ropas/soundPantalon.mp3'),
      ItemWord(
          idWord: 10,
          imagePath: 'assets/images/words/ropas/iconVestido.png',
          title: 'Vestido',
          soundPath: 'sounds/ropas/soundVestido.mp3'),
      ItemWord(
          idWord: 11,
          imagePath: 'assets/images/words/ropas/iconZapato.png',
          title: 'Zapatos',
          soundPath: 'sounds/ropas/soundZapatos.mp3'),
      ItemWord(
          idWord: 12,
          imagePath: 'assets/images/words/ropas/iconMedias.png',
          title: 'Calcetines',
          soundPath: 'sounds/ropas/soundCalcetines.mp3'),
      ItemWord(
          idWord: 13,
          imagePath: 'assets/images/words/ropas/iconSombrero.png',
          title: 'Sombrero',
          soundPath: 'sounds/ropas/soundSombrero.mp3'),
      ItemWord(
          idWord: 14,
          imagePath: 'assets/images/words/ropas/iconAbrigo.png',
          title: 'Abrigo',
          soundPath: 'sounds/ropas/soundAbrigo.mp3'),
    ]),
    ItemWordType(id: 3, typeWord: 'Familia', listItemWord: [
      ItemWord(
          idWord: 15,
          imagePath: 'assets/images/conversationIcon.png',
          title: 'Mamá',
          soundPath: 'assets/sound/ejemploSonido.mp3'),
      ItemWord(
          idWord: 16,
          imagePath: 'assets/images/conversationIcon.png',
          title: 'Papá',
          soundPath: 'assets/sound/ejemploSonido.mp3'),
      ItemWord(
          idWord: 17,
          imagePath: 'assets/images/conversationIcon.png',
          title: 'Hermano',
          soundPath: 'assets/sound/ejemploSonido.mp3'),
      ItemWord(
          idWord: 18,
          imagePath: 'assets/images/conversationIcon.png',
          title: 'Hermana',
          soundPath: 'assets/sound/ejemploSonido.mp3'),
      ItemWord(
          idWord: 19,
          imagePath: 'assets/images/conversationIcon.png',
          title: 'Abuela',
          soundPath: 'assets/sound/ejemploSonido.mp3'),
      ItemWord(
          idWord: 20,
          imagePath: 'assets/images/conversationIcon.png',
          title: 'Abuelo',
          soundPath: 'assets/sound/ejemploSonido.mp3'),
      ItemWord(
          idWord: 21,
          imagePath: 'assets/images/conversationIcon.png',
          title: 'Tía',
          soundPath: 'assets/sound/ejemploSonido.mp3'),
    ]),
    ItemWordType(id: 4, typeWord: 'Alimentos', listItemWord: [
      ItemWord(
          idWord: 22,
          imagePath: 'assets/images/conversationIcon.png',
          title: 'Pan',
          soundPath: 'assets/sound/ejemploSonido.mp3'),
      ItemWord(
          idWord: 23,
          imagePath: 'assets/images/conversationIcon.png',
          title: 'Leche',
          soundPath: 'assets/sound/ejemploSonido.mp3'),
      ItemWord(
          idWord: 24,
          imagePath: 'assets/images/conversationIcon.png',
          title: 'Agua',
          soundPath: 'assets/sound/ejemploSonido.mp3'),
      ItemWord(
          idWord: 25,
          imagePath: 'assets/images/conversationIcon.png',
          title: 'Jugo',
          soundPath: 'assets/sound/ejemploSonido.mp3'),
      ItemWord(
          idWord: 26,
          imagePath: 'assets/images/conversationIcon.png',
          title: 'Arroz',
          soundPath: 'assets/sound/ejemploSonido.mp3'),
      ItemWord(
          idWord: 27,
          imagePath: 'assets/images/conversationIcon.png',
          title: 'Pollo',
          soundPath: 'assets/sound/ejemploSonido.mp3'),
      ItemWord(
          idWord: 28,
          imagePath: 'assets/images/conversationIcon.png',
          title: 'Carne',
          soundPath: 'assets/sound/ejemploSonido.mp3'),
    ]),
    ItemWordType(id: 5, typeWord: 'Juegos', listItemWord: [
      ItemWord(
          idWord: 29,
          imagePath: 'assets/images/conversationIcon.png',
          title: 'Jugar',
          soundPath: 'assets/sound/ejemploSonido.mp3'),
      ItemWord(
          idWord: 30,
          imagePath: 'assets/images/conversationIcon.png',
          title: 'Correr',
          soundPath: 'assets/sound/ejemploSonido.mp3'),
      ItemWord(
          idWord: 31,
          imagePath: 'assets/images/conversationIcon.png',
          title: 'Saltar',
          soundPath: 'assets/sound/ejemploSonido.mp3'),
      ItemWord(
          idWord: 32,
          imagePath: 'assets/images/conversationIcon.png',
          title: 'Dibujar',
          soundPath: 'assets/sound/ejemploSonido.mp3'),
      ItemWord(
          idWord: 33,
          imagePath: 'assets/images/conversationIcon.png',
          title: 'Pintar',
          soundPath: 'assets/sound/ejemploSonido.mp3'),
      ItemWord(
          idWord: 34,
          imagePath: 'assets/images/conversationIcon.png',
          title: 'Cantar',
          soundPath: 'assets/sound/ejemploSonido.mp3'),
      ItemWord(
          idWord: 35,
          imagePath: 'assets/images/conversationIcon.png',
          title: 'Bailar',
          soundPath: 'assets/sound/ejemploSonido.mp3'),
    ]),
    ItemWordType(id: 6, typeWord: 'Animales', listItemWord: [
      ItemWord(
          idWord: 36,
          imagePath: 'assets/images/conversationIcon.png',
          title: 'Perro',
          soundPath: 'assets/sound/ejemploSonido.mp3'),
      ItemWord(
          idWord: 37,
          imagePath: 'assets/images/conversationIcon.png',
          title: 'Gato',
          soundPath: 'assets/sound/ejemploSonido.mp3'),
      ItemWord(
          idWord: 38,
          imagePath: 'assets/images/conversationIcon.png',
          title: 'Pájaro',
          soundPath: 'assets/sound/ejemploSonido.mp3'),
      ItemWord(
          idWord: 39,
          imagePath: 'assets/images/conversationIcon.png',
          title: 'Pez',
          soundPath: 'assets/sound/ejemploSonido.mp3'),
      ItemWord(
          idWord: 40,
          imagePath: 'assets/images/conversationIcon.png',
          title: 'Caballo',
          soundPath: 'assets/sound/ejemploSonido.mp3'),
      ItemWord(
          idWord: 41,
          imagePath: 'assets/images/conversationIcon.png',
          title: 'Vaca',
          soundPath: 'assets/sound/ejemploSonido.mp3'),
      ItemWord(
          idWord: 42,
          imagePath: 'assets/images/conversationIcon.png',
          title: 'Cerdo',
          soundPath: 'assets/sound/ejemploSonido.mp3'),
    ])
  ];

  static List<ItemWordType> getAll() => itemWord;
  // ✅ Método para obtener solo las palabras de un tipo específico
  static List<ItemWord> getWordsByType(int id) {
    return itemWord
        .firstWhere(
          (element) => element.id == id,
          orElse: () => ItemWordType(id: 0, typeWord: '', listItemWord: []),
        )
        .listItemWord;
  }
}
