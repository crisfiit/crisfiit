import 'package:shared_preferences/shared_preferences.dart';

import 'food_service.dart';

class HistoryService {

  static const String key = "history";

  static Future<void> addHistory(int foodId) async {

    final prefs = await SharedPreferences.getInstance();

    final history = await getHistory();

    history.remove(foodId);

    history.insert(0, foodId);

    if (history.length > 20) {
      history.removeRange(20, history.length);
    }

    await prefs.setStringList(
      key,
      history.map((id) => id.toString()).toList(),
    );

  }

  static Future<List<int>> getHistory() async {

    final prefs = await SharedPreferences.getInstance();

    final storedHistory = prefs.getStringList(key) ?? [];

    if (storedHistory.isEmpty) {
      return [];
    }

    final foods = await FoodService.loadFoods();

    final Map<String, int> foodIdsByName = {
      for (final food in foods)
        food.name: food.id,
    };

    final List<int> history = [];

    bool migrated = false;

    for (final value in storedHistory) {

      final id = int.tryParse(value);

      if (id != null) {
        // Ya está guardado como ID.
        if (foods.any((food) => food.id == id)) {
          history.add(id);
        } else {
          // El alimento ya no existe en la base de datos.
          migrated = true;
        }
      } else {
        // Historial de una versión anterior: estaba guardado como nombre.
        final foodId = foodIdsByName[value];

        if (foodId != null) {
          history.add(foodId);
        }

        migrated = true;
      }
    }

    // Eliminar posibles duplicados conservando el orden.
    final uniqueHistory = history.toSet().toList();

    if (migrated || uniqueHistory.length != storedHistory.length) {

      await prefs.setStringList(
        key,
        uniqueHistory.map((id) => id.toString()).toList(),
      );
    }

    return uniqueHistory;
  }

  static Future<void> clearHistory() async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(key);

  }

}