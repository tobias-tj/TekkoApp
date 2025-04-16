import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tekko/components/list_card_word.dart';
import 'package:tekko/components/top_custom_title.dart';
import 'package:tekko/data/list_item_word.dart';
import 'package:tekko/features/api/data/bloc/experience/experience_bloc.dart';
import 'package:tekko/features/services/favorites_services.dart';
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
  List<int> favoriteWordIds = [];
  int levelCurrent = 0;

  @override
  void initState() {
    super.initState();
    // Averiguar que nivel actual estamos
    final experienceState = context.read<ExperienceBloc>().state;
    if (experienceState is ExperienceLoaded) {
      levelCurrent = experienceState.experience.level;
    }
    // Filtrar palabras según el ID del tipo
    filteredItems = ItemWordData.getWordsByType(widget.id);
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final favorites = await FavoritesService.getFavorites();
    print("Palabras favoritas obtenidas:");
    print(favorites);
    if (mounted) {
      setState(() {
        favoriteWordIds = favorites;
      });
    }
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
                            maxCrossAxisExtent: 250,
                            mainAxisExtent: 170,
                            mainAxisSpacing: 10),
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      final isFavorite = favoriteWordIds.contains(item.idWord);
                      print('Visualizando actual nivel:');
                      print(levelCurrent);
                      return FadeInUp(
                          duration: Duration(milliseconds: 500 + (index * 100)),
                          child: ListCardWord(
                              key: ValueKey('${item.idWord}_$isFavorite'),
                              wordId: item.idWord,
                              imagePath: item.imagePath,
                              title: item.title,
                              soundPath: item.soundPath,
                              isFavorite: isFavorite));
                    }),
              ))
            ],
          )
        ]));
  }
}
