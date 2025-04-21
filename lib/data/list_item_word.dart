class ItemWordType {
  final int id;
  final String typeWord;
  final int level;
  final List<ItemWord> listItemWord;

  const ItemWordType(
      {required this.id,
      required this.typeWord,
      required this.level,
      required this.listItemWord});
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
    // Nivel 1
    ItemWordType(id: 1, typeWord: 'Conversacion', level: 1, listItemWord: [
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
    ItemWordType(id: 2, typeWord: 'Ropas', level: 1, listItemWord: [
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
    ItemWordType(id: 3, typeWord: 'Familia', level: 1, listItemWord: [
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
    ItemWordType(id: 4, typeWord: 'Alimentos', level: 1, listItemWord: [
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
    ItemWordType(id: 5, typeWord: 'Juegos', level: 1, listItemWord: [
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
    ItemWordType(id: 6, typeWord: 'Animales', level: 1, listItemWord: [
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
    ]
        // Finaliza nivel 1
        ),

    // Nivel 2
    ItemWordType(id: 7, typeWord: 'Acciones Diarias', level: 2, listItemWord: [
      ItemWord(
          idWord: 43,
          imagePath: 'assets/images/words/acciones/comer.png',
          title: 'Comer',
          soundPath: 'sounds/acciones/comer.mp3'),
      ItemWord(
          idWord: 44,
          imagePath: 'assets/images/words/acciones/beber.png',
          title: 'Beber',
          soundPath: 'sounds/acciones/soundBeber.mp3'),
      ItemWord(
          idWord: 45,
          imagePath: 'assets/images/words/acciones/cepillar.png',
          title: 'Cepillar',
          soundPath: 'sounds/acciones/soundCepillar.mp3'),
      ItemWord(
          idWord: 46,
          imagePath: 'assets/images/words/acciones/lavar.png',
          title: 'Lavarse',
          soundPath: 'sounds/acciones/soundLavarse.mp3'),
      ItemWord(
          idWord: 47,
          imagePath: 'assets/images/words/acciones/vestirse.png',
          title: 'Vestirse',
          soundPath: 'sounds/acciones/soundVestirse.mp3'),
      ItemWord(
          idWord: 48,
          imagePath: 'assets/images/words/acciones/dormir.png',
          title: 'Dormir',
          soundPath: 'sounds/acciones/soundDormir.mp3'),
      ItemWord(
          idWord: 49,
          imagePath: 'assets/images/words/acciones/despertar.png',
          title: 'Despertar',
          soundPath: 'sounds/acciones/soundDespertar.mp3'),
      ItemWord(
          idWord: 50,
          imagePath: 'assets/images/words/acciones/sentarse.png',
          title: 'Sentarse',
          soundPath: 'sounds/acciones/soundSentarse.mp3'),
      ItemWord(
          idWord: 51,
          imagePath: 'assets/images/words/acciones/pararse.png',
          title: 'Pararse',
          soundPath: 'sounds/acciones/soundPararse.mp3'),
      ItemWord(
          idWord: 52,
          imagePath: 'assets/images/words/acciones/banarse.png',
          title: 'Bañarse',
          soundPath: 'sounds/acciones/soundBanarse.mp3'),
    ]),

    ItemWordType(id: 8, typeWord: 'Emociones', level: 2, listItemWord: [
      ItemWord(
          idWord: 53,
          imagePath: 'assets/images/words/emociones/enojado.png',
          title: 'Enojado',
          soundPath: 'sounds/emociones/soundEnojado.mp3'),
      ItemWord(
          idWord: 54,
          imagePath: 'assets/images/words/emociones/asustadoIcon.png',
          title: 'Asustado',
          soundPath: 'sounds/emociones/soundAsustado.mp3'),
      ItemWord(
          idWord: 55,
          imagePath: 'assets/images/words/emociones/cansadoIcon.png',
          title: 'Cansado',
          soundPath: 'sounds/emociones/soundCansado.mp3'),
      ItemWord(
          idWord: 56,
          imagePath: 'assets/images/words/emociones/aburridoIcon.png',
          title: 'Aburrido',
          soundPath: 'sounds/emociones/soundAburrido.mp3'),
      ItemWord(
          idWord: 57,
          imagePath: 'assets/images/words/emociones/contentoIcon.png',
          title: 'Contento',
          soundPath: 'sounds/emociones/soundContento.mp3'),
      ItemWord(
          idWord: 58,
          imagePath: 'assets/images/words/emociones/nerviosoIcon.png',
          title: 'Nervioso',
          soundPath: 'sounds/emociones/soundNervioso.mp3'),
      ItemWord(
          idWord: 59,
          imagePath: 'assets/images/words/emociones/enfermoIcon.png',
          title: 'Enfermo',
          soundPath: 'sounds/emociones/soundEnfermo.mp3'),
      ItemWord(
          idWord: 60,
          imagePath: 'assets/images/words/emociones/sorprendidoIcon.png',
          title: 'Sorprendido',
          soundPath: 'sounds/emociones/soundSorprendido.mp3'),
    ]),

    ItemWordType(id: 9, typeWord: 'Escuela', level: 2, listItemWord: [
      ItemWord(
          idWord: 61,
          imagePath: 'assets/images/words/escuela/mochilaIcon.png',
          title: 'Mochila',
          soundPath: 'sounds/escuela/soundMochila.mp3'),
      ItemWord(
          idWord: 62,
          imagePath: 'assets/images/words/escuela/lapizIcon.png',
          title: 'Lápiz',
          soundPath: 'sounds/escuela/soundLapiz.mp3'),
      ItemWord(
          idWord: 63,
          imagePath: 'assets/images/words/escuela/libroIcon.png',
          title: 'Libro',
          soundPath: 'sounds/escuela/soundLibro.mp3'),
      ItemWord(
          idWord: 64,
          imagePath: 'assets/images/words/escuela/cuadernoIcon.png',
          title: 'Cuaderno',
          soundPath: 'sounds/escuela/soundCuaderno.mp3'),
      ItemWord(
          idWord: 65,
          imagePath: 'assets/images/words/escuela/maestraIcon.png',
          title: 'Maestra',
          soundPath: 'sounds/escuela/soundMaestra.mp3'),
      ItemWord(
          idWord: 66,
          imagePath: 'assets/images/words/escuela/amigoIcon.png',
          title: 'Amigo',
          soundPath: 'sounds/escuela/soundAmigo.mp3'),
      ItemWord(
          idWord: 67,
          imagePath: 'assets/images/words/escuela/aulaIcon.png',
          title: 'Aula',
          soundPath: 'sounds/escuela/soundAula.mp3'),
      ItemWord(
          idWord: 68,
          imagePath: 'assets/images/words/escuela/recreoIcon.png',
          title: 'Recreo',
          soundPath: 'sounds/escuela/soundRecreo.mp3'),
    ]),

    ItemWordType(id: 10, typeWord: 'Transporte', level: 2, listItemWord: [
      ItemWord(
          idWord: 69,
          imagePath: 'assets/images/words/transporte/autoIcon.png',
          title: 'Auto',
          soundPath: 'sounds/transporte/soundAuto.mp3'),
      ItemWord(
          idWord: 70,
          imagePath: 'assets/images/words/transporte/autobusIcon.png',
          title: 'Autobús',
          soundPath: 'sounds/transporte/soundAutobus.mp3'),
      ItemWord(
          idWord: 71,
          imagePath: 'assets/images/words/transporte/bicicletaIcon.png',
          title: 'Bicicleta',
          soundPath: 'sounds/transporte/soundBicicleta.mp3'),
      ItemWord(
          idWord: 72,
          imagePath: 'assets/images/words/transporte/motoIcon.png',
          title: 'Moto',
          soundPath: 'sounds/transporte/soundMoto.mp3'),
      ItemWord(
          idWord: 73,
          imagePath: 'assets/images/words/transporte/trenIcon.png',
          title: 'Tren',
          soundPath: 'sounds/transporte/soundTren.mp3'),
      ItemWord(
          idWord: 74,
          imagePath: 'assets/images/words/transporte/avionIcon.png',
          title: 'Avión',
          soundPath: 'sounds/transporte/soundAvion.mp3'),
      ItemWord(
          idWord: 75,
          imagePath: 'assets/images/words/transporte/barcoIcon.png',
          title: 'Barco',
          soundPath: 'sounds/transporte/soundBarco.mp3'),
      ItemWord(
          idWord: 76,
          imagePath: 'assets/images/words/transporte/calleIcon.png',
          title: 'Calle',
          soundPath: 'sounds/transporte/soundCalle.mp3'),
    ]),

    ItemWordType(
        id: 11,
        typeWord: 'Comidas Adicionales',
        level: 2,
        listItemWord: [
          ItemWord(
              idWord: 77,
              imagePath: 'assets/images/words/comidas/hamburguesaIcon.png',
              title: 'Hamburguesa',
              soundPath: 'sounds/comidas/soundHamburguesa.mp3'),
          ItemWord(
              idWord: 78,
              imagePath: 'assets/images/words/comidas/pizzaIcon.png',
              title: 'Pizza',
              soundPath: 'sounds/comidas/soundPizza.mp3'),
          ItemWord(
              idWord: 79,
              imagePath: 'assets/images/words/comidas/jugoFrutaIcon.png',
              title: 'Jugo de fruta',
              soundPath: 'sounds/comidas/soundJugoFruta.mp3'),
          ItemWord(
              idWord: 80,
              imagePath: 'assets/images/words/comidas/aguaGasIcon.png',
              title: 'Agua con gas',
              soundPath: 'sounds/comidas/soundAguaGas.mp3'),
          ItemWord(
              idWord: 81,
              imagePath: 'assets/images/words/comidas/yogurFresaIcon.png',
              title: 'Yogur de fresa',
              soundPath: 'sounds/comidas/soundYogurFresa.mp3'),
          ItemWord(
              idWord: 82,
              imagePath: 'assets/images/words/comidas/cerealIcon.png',
              title: 'Cereal',
              soundPath: 'sounds/comidas/soundCereal.mp3'),
          ItemWord(
              idWord: 83,
              imagePath: 'assets/images/words/comidas/mermeladaIcon.png',
              title: 'Mermelada',
              soundPath: 'sounds/comidas/soundMermelada.mp3'),
          ItemWord(
              idWord: 84,
              imagePath: 'assets/images/words/comidas/mantequillaIcon.png',
              title: 'Mantequilla',
              soundPath: 'sounds/comidas/soundMantequilla.mp3'),
        ]
        // Finaliza nivel 2
        ),
    // -----------------Nivel 3-----------------------------------
    ItemWordType(id: 12, typeWord: 'Frases útiles', level: 3, listItemWord: [
      ItemWord(
          idWord: 85,
          imagePath: 'assets/images/words/frases/tengoHambre.png',
          title: 'Tengo hambre',
          soundPath: 'sounds/frases/soundTengoHambre.mp3'),
      ItemWord(
          idWord: 86,
          imagePath: 'assets/images/words/frases/tengoSed.png',
          title: 'Tengo sed',
          soundPath: 'sounds/frases/soundTengoSed.mp3'),
      ItemWord(
          idWord: 87,
          imagePath: 'assets/images/words/frases/quieroJugar.png',
          title: 'Quiero jugar',
          soundPath: 'sounds/frases/soundQuieroJugar.mp3'),
      ItemWord(
          idWord: 88,
          imagePath: 'assets/images/words/frases/quieroDormir.png',
          title: 'Quiero dormir',
          soundPath: 'sounds/frases/soundQuieroDormir.mp3'),
      ItemWord(
          idWord: 89,
          imagePath: 'assets/images/words/frases/meDuele.png',
          title: 'Me duele',
          soundPath: 'sounds/frases/soundMeDuele.mp3'),
      ItemWord(
          idWord: 90,
          imagePath: 'assets/images/words/frases/noQuiero.png',
          title: 'No quiero',
          soundPath: 'sounds/frases/soundNoQuiero.mp3'),
      ItemWord(
          idWord: 91,
          imagePath: 'assets/images/words/frases/ayudame.png',
          title: 'Ayúdame',
          soundPath: 'sounds/frases/soundAyudame.mp3'),
      ItemWord(
          idWord: 92,
          imagePath: 'assets/images/words/frases/estoyFeliz.png',
          title: 'Estoy feliz',
          soundPath: 'sounds/frases/soundEstoyFeliz.mp3'),
    ]),

// Nivel 3 - Lugares
    ItemWordType(id: 13, typeWord: 'Lugares', level: 3, listItemWord: [
      ItemWord(
          idWord: 93,
          imagePath: 'assets/images/words/lugares/escuela.png',
          title: 'Escuela',
          soundPath: 'sounds/lugares/soundEscuela.mp3'),
      ItemWord(
          idWord: 94,
          imagePath: 'assets/images/words/lugares/casa.png',
          title: 'Casa',
          soundPath: 'sounds/lugares/soundCasa.mp3'),
      ItemWord(
          idWord: 95,
          imagePath: 'assets/images/words/lugares/bano.png',
          title: 'Baño',
          soundPath: 'sounds/lugares/soundBano.mp3'),
      ItemWord(
          idWord: 96,
          imagePath: 'assets/images/words/lugares/cocina.png',
          title: 'Cocina',
          soundPath: 'sounds/lugares/soundCocina.mp3'),
      ItemWord(
          idWord: 97,
          imagePath: 'assets/images/words/lugares/patio.png',
          title: 'Patio',
          soundPath: 'sounds/lugares/soundPatio.mp3'),
      ItemWord(
          idWord: 98,
          imagePath: 'assets/images/words/lugares/parque.png',
          title: 'Parque',
          soundPath: 'sounds/lugares/soundParque.mp3'),
      ItemWord(
          idWord: 99,
          imagePath: 'assets/images/words/lugares/tienda.png',
          title: 'Tienda',
          soundPath: 'sounds/lugares/soundTienda.mp3'),
      ItemWord(
          idWord: 100,
          imagePath: 'assets/images/words/lugares/hospital.png',
          title: 'Hospital',
          soundPath: 'sounds/lugares/soundHospital.mp3'),
    ]),

// Nivel 3 - Clima
    ItemWordType(id: 14, typeWord: 'Clima', level: 3, listItemWord: [
      ItemWord(
          idWord: 101,
          imagePath: 'assets/images/words/clima/haceCalor.png',
          title: 'Hace calor',
          soundPath: 'sounds/clima/soundHaceCalor.mp3'),
      ItemWord(
          idWord: 102,
          imagePath: 'assets/images/words/clima/haceFrio.png',
          title: 'Hace frío',
          soundPath: 'sounds/clima/soundHaceFrio.mp3'),
      ItemWord(
          idWord: 103,
          imagePath: 'assets/images/words/clima/llueve.png',
          title: 'Llueve',
          soundPath: 'sounds/clima/soundLlueve.mp3'),
      ItemWord(
          idWord: 104,
          imagePath: 'assets/images/words/clima/nublado.png',
          title: 'Nublado',
          soundPath: 'sounds/clima/soundNublado.mp3'),
      ItemWord(
          idWord: 105,
          imagePath: 'assets/images/words/clima/sol.png',
          title: 'Sol',
          soundPath: 'sounds/clima/soundSol.mp3'),
      ItemWord(
          idWord: 106,
          imagePath: 'assets/images/words/clima/nieve.png',
          title: 'Nieve',
          soundPath: 'sounds/clima/soundNieve.mp3'),
      ItemWord(
          idWord: 107,
          imagePath: 'assets/images/words/clima/tormenta.png',
          title: 'Tormenta',
          soundPath: 'sounds/clima/soundTormenta.mp3'),
      ItemWord(
          idWord: 108,
          imagePath: 'assets/images/words/clima/viento.png',
          title: 'Viento',
          soundPath: 'sounds/clima/soundViento.mp3'),
    ]),

// Nivel 3 - Objetos comunes
    ItemWordType(id: 15, typeWord: 'Objetos comunes', level: 3, listItemWord: [
      ItemWord(
          idWord: 109,
          imagePath: 'assets/images/words/objetos/silla2.png',
          title: 'Silla',
          soundPath: 'sounds/objetos/soundSilla.mp3'),
      ItemWord(
          idWord: 110,
          imagePath: 'assets/images/words/objetos/mesa.png',
          title: 'Mesa',
          soundPath: 'sounds/objetos/soundMesa.mp3'),
      ItemWord(
          idWord: 111,
          imagePath: 'assets/images/words/objetos/cama.png',
          title: 'Cama',
          soundPath: 'sounds/objetos/soundCama.mp3'),
      ItemWord(
          idWord: 112,
          imagePath: 'assets/images/words/objetos/puerta.png',
          title: 'Puerta',
          soundPath: 'sounds/objetos/soundPuerta.mp3'),
      ItemWord(
          idWord: 113,
          imagePath: 'assets/images/words/objetos/ventana.png',
          title: 'Ventana',
          soundPath: 'sounds/objetos/soundVentana.mp3'),
      ItemWord(
          idWord: 114,
          imagePath: 'assets/images/words/objetos/lampara.png',
          title: 'Lámpara',
          soundPath: 'sounds/objetos/soundLampara.mp3'),
      ItemWord(
          idWord: 115,
          imagePath: 'assets/images/words/objetos/cepillo.png',
          title: 'Cepillo',
          soundPath: 'sounds/objetos/soundCepillo.mp3'),
      ItemWord(
          idWord: 116,
          imagePath: 'assets/images/words/objetos/reloj.png',
          title: 'Reloj',
          soundPath: 'sounds/objetos/soundReloj.mp3'),
    ]
        // Finaliza nivel 3
        ),
    // -------------------------Nivel 4------------------------------
    ItemWordType(
        id: 16,
        typeWord: 'Preguntas simples',
        level: 4,
        listItemWord: [
          ItemWord(
              idWord: 117,
              imagePath: 'assets/images/words/preguntas/queEsEsto.png',
              title: '¿Qué es esto?',
              soundPath: 'sounds/preguntas/soundQueEsEsto.mp3'),
          ItemWord(
              idWord: 118,
              imagePath: 'assets/images/words/preguntas/dondeEstaMama.png',
              title: '¿Dónde está mamá?',
              soundPath: 'sounds/preguntas/soundDondeEstaMama.mp3'),
          ItemWord(
              idWord: 119,
              imagePath: 'assets/images/words/preguntas/puedoIr.png',
              title: '¿Puedo ir?',
              soundPath: 'sounds/preguntas/soundPuedoIr.mp3'),
          ItemWord(
              idWord: 120,
              imagePath: 'assets/images/words/preguntas/quehaces.png',
              title: '¿Qué haces?',
              soundPath: 'sounds/preguntas/soundQueHaces.mp3'),
          ItemWord(
              idWord: 121,
              imagePath: 'assets/images/words/preguntas/vamosAlParque.png',
              title: '¿Vamos al parque?',
              soundPath: 'sounds/preguntas/soundVamosAlParque.mp3'),
          ItemWord(
              idWord: 122,
              imagePath: 'assets/images/words/preguntas/tienesHambre.png',
              title: '¿Tienes hambre?',
              soundPath: 'sounds/preguntas/soundTienesHambre.mp3'),
          ItemWord(
              idWord: 123,
              imagePath: 'assets/images/words/preguntas/estasBien.png',
              title: '¿Estás bien?',
              soundPath: 'sounds/preguntas/soundEstasBien.mp3'),
        ]),

// Nivel 4 - Preferencias
    ItemWordType(id: 17, typeWord: 'Preferencias', level: 4, listItemWord: [
      ItemWord(
          idWord: 124,
          imagePath: 'assets/images/words/preferencias/meGusta.png',
          title: 'Me gusta',
          soundPath: 'sounds/preferencias/soundMeGusta.mp3'),
      ItemWord(
          idWord: 125,
          imagePath: 'assets/images/words/preferencias/noMeGusta.png',
          title: 'No me gusta',
          soundPath: 'sounds/preferencias/soundNoMeGusta.mp3'),
      ItemWord(
          idWord: 126,
          imagePath: 'assets/images/words/preferencias/prefieroEsto.png',
          title: 'Prefiero esto',
          soundPath: 'sounds/preferencias/soundPrefieroEsto.mp3'),
      ItemWord(
          idWord: 127,
          imagePath: 'assets/images/words/preferencias/quieroEste.png',
          title: 'Quiero este',
          soundPath: 'sounds/preferencias/soundQuieroEste.mp3'),
      ItemWord(
          idWord: 128,
          imagePath: 'assets/images/words/preferencias/noQuieroEse.png',
          title: 'No quiero ese',
          soundPath: 'sounds/preferencias/soundNoQuieroEse.mp3'),
      ItemWord(
          idWord: 129,
          imagePath: 'assets/images/words/preferencias/esteSi.png',
          title: 'Este sí',
          soundPath: 'sounds/preferencias/soundEsteSi.mp3'),
      ItemWord(
          idWord: 130,
          imagePath: 'assets/images/words/preferencias/eseNo.png',
          title: 'Ese no',
          soundPath: 'sounds/preferencias/soundEseNo.mp3'),
    ]),

// Nivel 4 - Tiempo
    ItemWordType(id: 18, typeWord: 'Tiempo', level: 4, listItemWord: [
      ItemWord(
          idWord: 131,
          imagePath: 'assets/images/words/tiempo/hoy.png',
          title: 'Hoy',
          soundPath: 'sounds/tiempo/soundHoy.mp3'),
      ItemWord(
          idWord: 132,
          imagePath: 'assets/images/words/tiempo/ayer.png',
          title: 'Ayer',
          soundPath: 'sounds/tiempo/soundAyer.mp3'),
      ItemWord(
          idWord: 133,
          imagePath: 'assets/images/words/tiempo/manana.png',
          title: 'Mañana',
          soundPath: 'sounds/tiempo/soundManana.mp3'),
      ItemWord(
          idWord: 134,
          imagePath: 'assets/images/words/tiempo/tarde.png',
          title: 'Tarde',
          soundPath: 'sounds/tiempo/soundTarde.mp3'),
      ItemWord(
          idWord: 135,
          imagePath: 'assets/images/words/tiempo/mananaParte.png',
          title: 'De Mañana',
          soundPath: 'sounds/tiempo/soundManana.mp3'),
      ItemWord(
          idWord: 136,
          imagePath: 'assets/images/words/tiempo/noche.png',
          title: 'Noche',
          soundPath: 'sounds/tiempo/soundNoche.mp3'),
      ItemWord(
          idWord: 137,
          imagePath: 'assets/images/words/tiempo/dia.png',
          title: 'Día',
          soundPath: 'sounds/tiempo/soundDia.mp3'),
      ItemWord(
          idWord: 138,
          imagePath: 'assets/images/words/tiempo/semana.png',
          title: 'Semana',
          soundPath: 'sounds/tiempo/soundSemana.mp3'),
    ]),

// Nivel 4 - Colores y tamaños
    ItemWordType(
        id: 19,
        typeWord: 'Colores y tamaños',
        level: 4,
        listItemWord: [
          ItemWord(
              idWord: 139,
              imagePath: 'assets/images/words/coloresTam/rojo.png',
              title: 'Rojo',
              soundPath: 'sounds/coloresTam/soundRojo.mp3'),
          ItemWord(
              idWord: 140,
              imagePath: 'assets/images/words/coloresTam/azul.png',
              title: 'Azul',
              soundPath: 'sounds/coloresTam/soundAzul.mp3'),
          ItemWord(
              idWord: 141,
              imagePath: 'assets/images/words/coloresTam/verde.png',
              title: 'Verde',
              soundPath: 'sounds/coloresTam/soundVerde.mp3'),
          ItemWord(
              idWord: 142,
              imagePath: 'assets/images/words/coloresTam/amarillo.png',
              title: 'Amarillo',
              soundPath: 'sounds/coloresTam/soundAmarillo.mp3'),
          ItemWord(
              idWord: 143,
              imagePath: 'assets/images/words/coloresTam/grande.png',
              title: 'Grande',
              soundPath: 'sounds/coloresTam/soundGrande.mp3'),
          ItemWord(
              idWord: 144,
              imagePath: 'assets/images/words/coloresTam/pequenio.png',
              title: 'Pequeño',
              soundPath: 'sounds/coloresTam/soundPequenio.mp3'),
          ItemWord(
              idWord: 145,
              imagePath: 'assets/images/words/coloresTam/largo.png',
              title: 'Largo',
              soundPath: 'sounds/coloresTam/soundLargo.mp3'),
          ItemWord(
              idWord: 146,
              imagePath: 'assets/images/words/coloresTam/corto.png',
              title: 'Corto',
              soundPath: 'sounds/coloresTam/soundCorto.mp3'),
        ]
// Finaliza nivel 4
        ),
    // ----------------------Nivel 5 ------------------------------
    ItemWordType(
      id: 20,
      typeWord: 'Mensajes funcionales',
      level: 5,
      listItemWord: [
        ItemWord(
            idWord: 147,
            imagePath: 'assets/images/words/frases/baño.png',
            title: 'Necesito ir al baño',
            soundPath: 'sounds/frases/needBathroom.mp3'),
        ItemWord(
            idWord: 148,
            imagePath: 'assets/images/words/frases/frio.png',
            title: 'Tengo frío',
            soundPath: 'sounds/frases/cold.mp3'),
        ItemWord(
            idWord: 149,
            imagePath: 'assets/images/words/frases/cansado.png',
            title: 'Estoy cansado',
            soundPath: 'sounds/frases/tired.mp3'),
        ItemWord(
            idWord: 150,
            imagePath: 'assets/images/words/frases/mal.png',
            title: 'Me siento mal',
            soundPath: 'sounds/frases/bad.mp3'),
        ItemWord(
            idWord: 151,
            imagePath: 'assets/images/words/frases/noEntiendo.png',
            title: 'No entiendo',
            soundPath: 'sounds/frases/dontUnderstand.mp3'),
        ItemWord(
            idWord: 152,
            imagePath: 'assets/images/words/frases/dameEso.png',
            title: 'Dame eso, por favor',
            soundPath: 'sounds/frases/giveMeThat.mp3'),
        ItemWord(
            idWord: 153,
            imagePath: 'assets/images/words/frases/roto.png',
            title: 'Está roto',
            soundPath: 'sounds/frases/broken.mp3'),
        ItemWord(
            idWord: 154,
            imagePath: 'assets/images/words/frases/estaBien.png',
            title: 'Eso está bien',
            soundPath: 'sounds/frases/itsOk.mp3'),
      ],
    ),

    ItemWordType(
      id: 21,
      typeWord: 'Socializar',
      level: 5,
      listItemWord: [
        ItemWord(
            idWord: 155,
            imagePath: 'assets/images/words/social/jugar.png',
            title: '¿Quieres jugar?',
            soundPath: 'sounds/social/play.mp3'),
        ItemWord(
            idWord: 156,
            imagePath: 'assets/images/words/social/ven.png',
            title: 'Ven conmigo',
            soundPath: 'sounds/social/comeWithMe.mp3'),
        ItemWord(
            idWord: 157,
            imagePath: 'assets/images/words/social/felizContigo.png',
            title: 'Estoy feliz contigo',
            soundPath: 'sounds/social/happyWithYou.mp3'),
        ItemWord(
            idWord: 158,
            imagePath: 'assets/images/words/social/meGustaEsto.png',
            title: 'Me gusta esto',
            soundPath: 'sounds/social/iLikeThis.mp3'),
        ItemWord(
            idWord: 159,
            imagePath: 'assets/images/words/social/noMeGustaEso.png',
            title: 'No me gusta eso',
            soundPath: 'sounds/social/dontLikeThat.mp3'),
        ItemWord(
            idWord: 160,
            imagePath: 'assets/images/words/social/loHicisteBien.png',
            title: 'Lo hiciste bien',
            soundPath: 'sounds/social/wellDone.mp3'),
        ItemWord(
            idWord: 161,
            imagePath: 'assets/images/words/social/gracias.png',
            title: 'Gracias por ayudarme',
            soundPath: 'sounds/social/thanksHelp.mp3'),
      ],
    ),

    ItemWordType(
      id: 22,
      typeWord: 'Secuencias',
      level: 5,
      listItemWord: [
        ItemWord(
            idWord: 162,
            imagePath: 'assets/images/words/tiempo/primero.png',
            title: 'Primero',
            soundPath: 'sounds/tiempo/first.mp3'),
        ItemWord(
            idWord: 163,
            imagePath: 'assets/images/words/tiempo/despues.png',
            title: 'Después',
            soundPath: 'sounds/tiempo/after.mp3'),
        ItemWord(
            idWord: 164,
            imagePath: 'assets/images/words/tiempo/luego.png',
            title: 'Luego',
            soundPath: 'sounds/tiempo/then.mp3'),
        ItemWord(
            idWord: 165,
            imagePath: 'assets/images/words/tiempo/ahora.png',
            title: 'Ahora',
            soundPath: 'sounds/tiempo/now.mp3'),
        ItemWord(
            idWord: 166,
            imagePath: 'assets/images/words/tiempo/antes.png',
            title: 'Antes',
            soundPath: 'sounds/tiempo/before.mp3'),
        ItemWord(
            idWord: 167,
            imagePath: 'assets/images/words/tiempo/siempre.png',
            title: 'Siempre',
            soundPath: 'sounds/tiempo/always.mp3'),
        ItemWord(
            idWord: 168,
            imagePath: 'assets/images/words/tiempo/nunca.png',
            title: 'Nunca',
            soundPath: 'sounds/tiempo/never.mp3'),
      ],
    ),

    ItemWordType(
      id: 23,
      typeWord: 'Seguridad',
      level: 5,
      listItemWord: [
        ItemWord(
            idWord: 169,
            imagePath: 'assets/images/words/seguridad/noToques.png',
            title: 'No toques',
            soundPath: 'sounds/seguridad/dontTouch.mp3'),
        ItemWord(
            idWord: 170,
            imagePath: 'assets/images/words/seguridad/cuidado.png',
            title: 'Cuidado',
            soundPath: 'sounds/seguridad/careful.mp3'),
        ItemWord(
            idWord: 171,
            imagePath: 'assets/images/words/seguridad/caliente.png',
            title: 'Está caliente',
            soundPath: 'sounds/seguridad/hot.mp3'),
        ItemWord(
            idWord: 172,
            imagePath: 'assets/images/words/seguridad/peligroso.png',
            title: 'Es peligroso',
            soundPath: 'sounds/seguridad/danger.mp3'),
        ItemWord(
            idWord: 173,
            imagePath: 'assets/images/words/seguridad/venAqui.png',
            title: 'Ven aquí',
            soundPath: 'sounds/seguridad/comeHere.mp3'),
        ItemWord(
            idWord: 174,
            imagePath: 'assets/images/words/seguridad/espera.png',
            title: 'Espera',
            soundPath: 'sounds/seguridad/wait.mp3'),
        ItemWord(
            idWord: 175,
            imagePath: 'assets/images/words/seguridad/abrePuerta.png',
            title: 'Abre la puerta',
            soundPath: 'sounds/seguridad/openDoor.mp3'),
        ItemWord(
            idWord: 176,
            imagePath: 'assets/images/words/seguridad/cierraPuerta.png',
            title: 'Cierra la puerta',
            soundPath: 'sounds/seguridad/closeDoor.mp3'),
      ],
    ),
  ];

  static List<ItemWordType> getAll() => itemWord;
  // ✅ Método para obtener solo las palabras de un tipo específico
  static List<ItemWord> getWordsByType(int id) {
    return itemWord
        .firstWhere(
          (element) => element.id == id,
          orElse: () =>
              ItemWordType(id: 0, typeWord: '', level: 1, listItemWord: []),
        )
        .listItemWord;
  }
}
