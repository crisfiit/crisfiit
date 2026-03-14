import '../models/food.dart';
import '../utils/equivalence_calculator.dart';

class EquivalenceService {

  static Map<String, dynamic> calculate(
    Food selectedFood,
    double grams,
    List<Food> foods,
  ) {

    final double factor = grams / selectedFood.grams;

    final List<Map<String, dynamic>> results = [];

    for (final food in foods) {

      if (food.group != selectedFood.group) continue;

      if (food.name == selectedFood.name) continue;

      final equivalentGrams = factor * food.grams;

      results.add({
        "food": food,
        "grams": equivalentGrams,
      });

    }

    // 🔹 ORDENAR POR CERCANÍA A LOS GRAMOS INTRODUCIDOS
    results.sort((a, b) {

      final double g1 = a["grams"];
      final double g2 = b["grams"];

      final diff1 = (g1 - grams).abs();
      final diff2 = (g2 - grams).abs();

      return diff1.compareTo(diff2);

    });

    final portions =
        PortionCalculator.calculatePortions(selectedFood, grams);

    return {
      "equivalences": results,
      "portions": portions,
    };

  }

}