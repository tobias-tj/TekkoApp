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
          imagePath: 'assets/images/words/conversacion/buendiaIcon.png',
          title: 'Buenos \nDías!',
          soundPath: 'sounds/conversacion/soundBuenDia.mp3'),
      ItemWord(
          idWord: 4,
          imagePath: 'assets/images/words/conversacion/nocheIcon.png',
          title: 'Buenas \nNoches',
          soundPath: 'sounds/conversacion/soundBuenasNoches.mp3'),
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
          imagePath: 'assets/images/words/familia/momIcon.png',
          title: 'Mamá',
          soundPath: 'sounds/familia/soundMama.mp3'),
      ItemWord(
          idWord: 16,
          imagePath: 'assets/images/words/familia/dadIcon.png',
          title: 'Papá',
          soundPath: 'sounds/familia/soundPapa.mp3'),
      ItemWord(
          idWord: 17,
          imagePath: 'assets/images/words/familia/hermanoIcon.png',
          title: 'Hermano',
          soundPath: 'sounds/familia/soundHermano.mp3'),
      ItemWord(
          idWord: 18,
          imagePath: 'assets/images/words/familia/hermanaIcon.png',
          title: 'Hermana',
          soundPath: 'sounds/familia/soundHermana.mp3'),
      ItemWord(
          idWord: 19,
          imagePath: 'assets/images/words/familia/abuelaIcon.png',
          title: 'Abuela',
          soundPath: 'sounds/familia/soundAbuela.mp3'),
      ItemWord(
          idWord: 20,
          imagePath: 'assets/images/words/familia/abueloIcon.png',
          title: 'Abuelo',
          soundPath: 'sounds/familia/soundAbuelo.mp3'),
      ItemWord(
          idWord: 21,
          imagePath: 'assets/images/words/familia/tiaIcon.png',
          title: 'Tía',
          soundPath: 'sounds/familia/soundTia.mp3'),
    ]),
    ItemWordType(id: 4, typeWord: 'Alimentos', listItemWord: [
      ItemWord(
          idWord: 22,
          imagePath: 'assets/images/words/alimentos/panIcon.png',
          title: 'Pan',
          soundPath: 'sounds/alimentos/soundPan.mp3'),
      ItemWord(
          idWord: 23,
          imagePath: 'assets/images/words/alimentos/lecheIcon.png',
          title: 'Leche',
          soundPath: 'sounds/alimentos/soundLeche.mp3'),
      ItemWord(
          idWord: 24,
          imagePath: 'assets/images/words/alimentos/aguaIcon.png',
          title: 'Agua',
          soundPath: 'sounds/alimentos/soundAgua.mp3'),
      ItemWord(
          idWord: 25,
          imagePath: 'assets/images/words/alimentos/jugoIcon.png',
          title: 'Jugo',
          soundPath: 'sounds/alimentos/soundJugo.mp3'),
      ItemWord(
          idWord: 26,
          imagePath: 'assets/images/words/alimentos/arrozIcon.png',
          title: 'Arroz',
          soundPath: 'sounds/alimentos/soundArroz.mp3'),
      ItemWord(
          idWord: 27,
          imagePath: 'assets/images/words/alimentos/polloIcon.png',
          title: 'Pollo',
          soundPath: 'sounds/alimentos/soundPollo.mp3'),
      ItemWord(
          idWord: 28,
          imagePath: 'assets/images/words/alimentos/carneIcon.png',
          title: 'Carne',
          soundPath: 'sounds/alimentos/soundCarne.mp3'),
    ]),
    ItemWordType(id: 5, typeWord: 'Juegos', listItemWord: [
      ItemWord(
          idWord: 29,
          imagePath: 'assets/images/words/juegos/juegoIcon.png',
          title: 'Jugar',
          soundPath: 'sounds/juegos/soundJugar.mp3'),
      ItemWord(
          idWord: 30,
          imagePath: 'assets/images/words/juegos/correrIcon.png',
          title: 'Correr',
          soundPath: 'sounds/juegos/soundCorrer.mp3'),
      ItemWord(
          idWord: 31,
          imagePath: 'assets/images/words/juegos/saltarIcon.png',
          title: 'Saltar',
          soundPath: 'sounds/juegos/soundSaltar.mp3'),
      ItemWord(
          idWord: 32,
          imagePath: 'assets/images/words/juegos/dibujarIcon.png',
          title: 'Dibujar',
          soundPath: 'sounds/juegos/soundDibujar.mp3'),
      ItemWord(
          idWord: 33,
          imagePath: 'assets/images/words/juegos/pintarIcon.png',
          title: 'Pintar',
          soundPath: 'sounds/juegos/soundPintar.mp3'),
      ItemWord(
          idWord: 34,
          imagePath: 'assets/images/words/juegos/cantarIcon.png',
          title: 'Cantar',
          soundPath: 'sounds/juegos/soundCantar.mp3'),
      ItemWord(
          idWord: 35,
          imagePath: 'assets/images/words/juegos/bailarIcon.png',
          title: 'Bailar',
          soundPath: 'sounds/juegos/soundBailar.mp3'),
    ]),
    ItemWordType(id: 6, typeWord: 'Animales', listItemWord: [
      ItemWord(
          idWord: 36,
          imagePath: 'assets/images/words/animales/perroIcon.png',
          title: 'Perro',
          soundPath: 'sounds/animales/soundPerro.mp3'),
      ItemWord(
          idWord: 37,
          imagePath: 'assets/images/words/animales/gatoIcon.png',
          title: 'Gato',
          soundPath: 'sounds/animales/soundGato.mp3'),
      ItemWord(
          idWord: 38,
          imagePath: 'assets/images/words/animales/pajaroIcon.png',
          title: 'Pájaro',
          soundPath: 'sounds/animales/soundPajaro.mp3'),
      ItemWord(
          idWord: 39,
          imagePath: 'assets/images/words/animales/pescadoIcon.png',
          title: 'Pescado',
          soundPath: 'sounds/animales/soundPescado.mp3'),
      ItemWord(
          idWord: 40,
          imagePath: 'assets/images/words/animales/caballoIcon.png',
          title: 'Caballo',
          soundPath: 'sounds/animales/soundCaballo.mp3'),
      ItemWord(
          idWord: 41,
          imagePath: 'assets/images/words/animales/vacaIcon.png',
          title: 'Vaca',
          soundPath: 'sounds/animales/soundVaca.mp3'),
      ItemWord(
          idWord: 42,
          imagePath: 'assets/images/words/animales/cerdoIcon.png',
          title: 'Cerdo',
          soundPath: 'sounds/animales/soundCerdo.mp3'),
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
