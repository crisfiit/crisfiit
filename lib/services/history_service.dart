import 'package:shared_preferences/shared_preferences.dart';

class HistoryService {

  static const String key = "history";

  static Future<void> addHistory(String food) async {

    final prefs = await SharedPreferences.getInstance();

    List<String> history = prefs.getStringList(key) ?? [];

    history.remove(food);

    history.insert(0, food);

    if (history.length > 20) {
      history = history.sublist(0, 20);
    }

    await prefs.setStringList(key, history);

  }

  static Future<List<String>> getHistory() async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getStringList(key) ?? [];

  }

  static Future<void> clearHistory() async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(key);

  }

}