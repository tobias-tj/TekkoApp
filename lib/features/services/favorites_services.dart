import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const String _favoritesKey = 'favorite_words';
  static List<int> _cachedFavorites = [];

  static Future<void> _updateCache() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_favoritesKey) ?? [];
    _cachedFavorites = favorites.map((id) => int.parse(id)).toList();
  }

  static Future<List<int>> getFavorites() async {
    if (_cachedFavorites.isEmpty) {
      await _updateCache();
    }
    return _cachedFavorites;
  }

  static Future<bool> isFavorite(int wordId) async {
    final favorites = await getFavorites();
    return favorites.contains(wordId);
  }

  static Future<void> addFavorite(int wordId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    if (!favorites.contains(wordId)) {
      favorites.add(wordId);
      await prefs.setStringList(
        _favoritesKey,
        favorites.map((id) => id.toString()).toList(),
      );
      _cachedFavorites = favorites;
    }
  }

  static Future<void> removeFavorite(int wordId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    favorites.remove(wordId);
    await prefs.setStringList(
      _favoritesKey,
      favorites.map((id) => id.toString()).toList(),
    );
    _cachedFavorites = favorites;
  }
}
