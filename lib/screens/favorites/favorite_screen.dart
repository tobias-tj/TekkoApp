import 'package:flutter/material.dart';
import 'package:tekko/components/top_custom_calendar.dart';
import 'package:tekko/components/top_title_generic.dart';
import 'package:tekko/data/list_item_word.dart';
import 'package:tekko/screens/favorites/item_word_card.dart';
import 'package:tekko/styles/app_colors.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final allItems =
        ItemWordData.getAll().expand((type) => type.listItemWord).toList();

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
              TopTitleGeneric(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 180,
                            mainAxisExtent: 180,
                            mainAxisSpacing: 18,
                            crossAxisSpacing: 16),
                    itemCount: allItems.length,
                    itemBuilder: (context, index) {
                      final item = allItems[index];
                      return ItemWordCard(item: item);
                    },
                  ),
                ),
              ),
            ],
          )
        ]));
  }
}
