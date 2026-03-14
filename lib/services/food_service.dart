import '../models/food.dart';
import 'database_service.dart';

class FoodService {

static Future<List<Food>> loadFoods() async {

final db = await DatabaseService.getDatabase();

final List<Map<String, dynamic>> result = await db.query("foods");

return result.map<Food>((row) {

  return Food(
    name: (row["name"] ?? "") as String,
    grams: ((row["grams"] ?? 0) as num).toInt(),
    category: (row["category"] ?? "") as String,
    group: (row["group_name"] ?? "") as String,
  );

}).toList();

}

}
