import 'package:flutter/material.dart';
import 'package:tekko/components/list_card_item_home.dart';
import 'package:tekko/components/top_custom_background.dart';
import 'package:tekko/styles/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> items = [
    {
      'imagePath': 'assets/images/conversationIcon.png',
      'title': 'Conversacion'
    },
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
              TopCustomBackground(),
              const SizedBox(
                  height: 2), // Espaciado entre DialogHome y GridView
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
    );
  }
}
