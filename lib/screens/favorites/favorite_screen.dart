import 'package:flutter/material.dart';
import 'package:tekko/components/top_title_generic.dart';
import 'package:tekko/data/list_item_word.dart';
import 'package:tekko/features/services/favorites_services.dart';
import 'package:tekko/screens/favorites/item_word_card.dart';
import 'package:tekko/styles/app_colors.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<ItemWord> _favoriteWords = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final favoriteIds = await FavoritesService.getFavorites();
    final allWords =
        ItemWordData.getAll().expand((type) => type.listItemWord).toList();

    setState(() {
      _favoriteWords =
          allWords.where((word) => favoriteIds.contains(word.idWord)).toList();
    });
  }

  // Método para actualizar cuando se quite un favorito
  void _onFavoriteRemoved() {
    _loadFavorites();
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
              TopTitleGeneric(
                title: "Favoritos",
              ),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26.0),
                      child: _favoriteWords.isEmpty
                          ? const Center(
                              child: Text(
                                "No tienes palabras favoritas aun",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: AppColors.chocolateNewDark),
                              ),
                            )
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 180,
                                      mainAxisExtent: 180,
                                      mainAxisSpacing: 18,
                                      crossAxisSpacing: 16),
                              itemCount: _favoriteWords.length,
                              itemBuilder: (context, index) {
                                final item = _favoriteWords[index];
                                return ItemWordCard(
                                    item: item,
                                    onFavoriteRemoved: _onFavoriteRemoved);
                              },
                            ))),
            ],
          )
        ]));
  }
}
