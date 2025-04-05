import 'package:flutter/material.dart';
import 'package:tekko/components/list_card_word.dart';
import 'package:tekko/components/top_custom_title.dart';
import 'package:tekko/data/list_item_word.dart';
import 'package:tekko/styles/app_colors.dart';

class WordScreen extends StatefulWidget {
  final int id;
  final String textTitle;
  const WordScreen({super.key, required this.id, required this.textTitle});

  @override
  State<WordScreen> createState() => _WordScreenState();
}

class _WordScreenState extends State<WordScreen> {
  late List<ItemWord> filteredItems;

  @override
  void initState() {
    super.initState();
    // Filtrar palabras según el ID del tipo
    filteredItems = ItemWordData.getWordsByType(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: AppColors.softCream,
        body: Stack(children: [
          Container(
            width: size.width,
            height: size.height,
            color: AppColors.softCream,
          ),
          Column(
            children: [
              TopCustomTitle(title: widget.textTitle),
              const SizedBox(height: 2),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            mainAxisExtent: 170,
                            mainAxisSpacing: 10),
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return ListCardWord(
                        imagePath: item.imagePath,
                        title: item.title,
                        soundPath: item.soundPath,
                      );
                    }),
              ))
            ],
          )
        ]));
  }
}
