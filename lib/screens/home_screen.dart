import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:tekko/components/list_card_item_home.dart';
import 'package:tekko/components/top_custom_background.dart';
import 'package:tekko/data/list_item_home.dart';
import 'package:tekko/styles/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Item> items = ItemData.getAll();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: Column(
        children: [
          // Encabezado con animación
          FadeInDown(
            duration: const Duration(milliseconds: 500),
            child: const TopCustomBackground(),
          ),

          const SizedBox(height: 2),

          // Grid de items con animación escalonada
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 180,
                  mainAxisExtent: 150,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return FadeInUp(
                    duration: Duration(milliseconds: 500 + (index * 100)),
                    child: ListCardItemHome(
                      id: item.id,
                      imagePath: item.imagePath,
                      title: item.title,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
