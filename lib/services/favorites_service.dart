import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {

  static const String key = "favorites";

  static Future<List<String>> getFavorites() async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getStringList(key) ?? [];

  }

  static Future<void> addFavorite(String food) async {

    final prefs = await SharedPreferences.getInstance();

    List<String> favorites = prefs.getStringList(key) ?? [];

    if (!favorites.contains(food)) {
      favorites.add(food);
    }

    await prefs.setStringList(key, favorites);

  }

  static Future<void> removeFavorite(String food) async {

    final prefs = await SharedPreferences.getInstance();

    List<String> favorites = prefs.getStringList(key) ?? [];

    favorites.remove(food);

    await prefs.setStringList(key, favorites);

  }

  static Future<bool> isFavorite(String food) async {

    final prefs = await SharedPreferences.getInstance();

    List<String> favorites = prefs.getStringList(key) ?? [];

    return favorites.contains(food);

  }

}