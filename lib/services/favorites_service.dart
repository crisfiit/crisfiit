import 'package:shared_preferences/shared_preferences.dart';

import 'food_service.dart';

class FavoritesService {

  static const String key = "favorites";

  static Future<List<int>> getFavorites() async {

    final prefs = await SharedPreferences.getInstance();

    final storedFavorites = prefs.getStringList(key) ?? [];

    if (storedFavorites.isEmpty) {
      return [];
    }

    final foods = await FoodService.loadFoods();

    final Map<String, int> foodIdsByName = {
      for (final food in foods)
        food.name: food.id,
    };

    final List<int> favorites = [];

    bool migrated = false;

    for (final value in storedFavorites) {

      final id = int.tryParse(value);

      if (id != null) {
        // Ya está guardado como ID.
        if (foods.any((food) => food.id == id)) {
          favorites.add(id);
        } else {
          // El alimento ya no existe en la base de datos.
          migrated = true;
        }
      } else {
        // Favorito de una versión anterior: estaba guardado como nombre.
        final foodId = foodIdsByName[value];

        if (foodId != null) {
          favorites.add(foodId);
        }

        migrated = true;
      }
    }

    // Eliminar posibles duplicados conservando el orden.
    final uniqueFavorites = favorites.toSet().toList();

    if (migrated || uniqueFavorites.length != storedFavorites.length) {

      await prefs.setStringList(
        key,
        uniqueFavorites.map((id) => id.toString()).toList(),
      );
    }

    return uniqueFavorites;
  }

  static Future<void> addFavorite(int foodId) async {

    final prefs = await SharedPreferences.getInstance();

    final favorites = await getFavorites();

    if (!favorites.contains(foodId)) {
      favorites.add(foodId);
    }

    await prefs.setStringList(
      key,
      favorites.map((id) => id.toString()).toList(),
    );
  }

  static Future<void> removeFavorite(int foodId) async {

    final prefs = await SharedPreferences.getInstance();

    final favorites = await getFavorites();

    favorites.remove(foodId);

    await prefs.setStringList(
      key,
      favorites.map((id) => id.toString()).toList(),
    );
  }

  static Future<bool> isFavorite(int foodId) async {

    final favorites = await getFavorites();

    return favorites.contains(foodId);
  }

}