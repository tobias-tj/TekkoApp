import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tekko/components/dialog_home.dart';
import 'package:tekko/components/list_card_item_home.dart';
import 'package:tekko/components/top_custom_background.dart';
import 'package:tekko/styles/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _navigationItem = [
    const Icon(Icons.home_outlined),
    const Icon(Icons.calendar_month_outlined),
    const Icon(Icons.favorite_border),
    const Icon(Icons.notifications_none),
    const Icon(Icons.settings_outlined)
  ];

  final List<Map<String, dynamic>> items = [
    {'imagePath': 'assets/images/conversationIcon.png', 'title': 'Palabras'},
    {'imagePath': 'assets/images/ropIcon.png', 'title': 'Ropas'},
    {'imagePath': 'assets/images/familyIcon.png', 'title': 'Familia'},
    {'imagePath': 'assets/images/foodIcon.png', 'title': 'Alimentos'},
    {'imagePath': 'assets/images/gamesIcon.png', 'title': 'Juegos'},
    {'imagePath': 'assets/images/animalsIcon.png', 'title': 'Animales'},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            color: AppColors.softCream,
          ),
          Column(
            children: [
              TopCustomBackground(title: "Hola Tobias!"),

              DialogHome(),
              const SizedBox(
                  height: 10), // Espaciado entre DialogHome y GridView
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 180,
                      mainAxisExtent: 150, // Máximo ancho de cada tarjeta
                      mainAxisSpacing:
                          16, // Espaciado vertical entre las tarjetas
                      crossAxisSpacing:
                          16, // Espaciado horizontal entre las tarjetas
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ListCardItemHome(
                        imagePath: item['imagePath'],
                        title: item['title'],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: AppColors.softCream,
        color: AppColors.softCreamDark,
        buttonBackgroundColor: Colors.white,
        animationDuration: const Duration(milliseconds: 300),
        index: 0,
        items: _navigationItem,
        onTap: (index) {
          if (index == 0) {
            print(
                "Logica para ir a la pantalla de home que es en realidad en donde estamos actualmente");
          } else if (index == 1) {
            print("Logica para ir a la pantalla de calendario");
          } else if (index == 2) {
            print("logica para ir a la pantalla de favoritos");
          } else if (index == 3) {
            print("logica para ir a notificaciones");
          } else if (index == 4) {
            print("Logica para pantalla de settings");
          }
        },
      ),
    );
  }
}
