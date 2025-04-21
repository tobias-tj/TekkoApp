import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
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
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    setState(() => _isLoading = true);

    final favoriteIds = await FavoritesService.getFavorites();
    final allWords =
        ItemWordData.getAll().expand((type) => type.listItemWord).toList();

    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _favoriteWords =
          allWords.where((word) => favoriteIds.contains(word.idWord)).toList();
      _isLoading = false;
    });
  }

  void _onFavoriteRemoved() {
    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: Stack(
        children: [
          // Fondo decorativo animado
          Positioned(
            top: 0,
            child: Image.asset(
              'assets/images/topTitleAccount.png',
              width: size.width,
              fit: BoxFit.cover,
            ),
          ),

          Column(
            children: [
              // Título con animación
              BounceInDown(
                duration: const Duration(milliseconds: 700),
                child: const TopTitleGeneric(
                  title: "Favoritos",
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26.0),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : _favoriteWords.isEmpty
                          ? FadeIn(
                              duration: const Duration(milliseconds: 800),
                              child: const Center(
                                child: Text(
                                  "No tienes palabras favoritas aún",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AppColors.chocolateNewDark,
                                  ),
                                ),
                              ),
                            )
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 195,
                                mainAxisExtent: 180,
                                mainAxisSpacing: 18,
                                crossAxisSpacing: 16,
                              ),
                              itemCount: _favoriteWords.length,
                              itemBuilder: (context, index) {
                                final item = _favoriteWords[index];
                                return FadeInUp(
                                  duration: Duration(
                                      milliseconds: 500 + (index * 100)),
                                  child: ItemWordCard(
                                    item: item,
                                    onFavoriteRemoved: _onFavoriteRemoved,
                                  ),
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
