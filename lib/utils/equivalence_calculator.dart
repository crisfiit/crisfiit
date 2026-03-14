import '../models/food.dart';

class PortionCalculator {

  static FoodPortions calculatePortions(
    Food food,
    double grams,
  ) {

    if (food.grams <= 0) {
      return const FoodPortions(hc: 0, pr: 0, gr: 0);
    }

    final factor = grams / food.grams;

    final base = _groupBasePortions(food.group);

    return FoodPortions(
      hc: base.hc * factor,
      pr: base.pr * factor,
      gr: base.gr * factor,
    );

  }

  static FoodPortions _groupBasePortions(String group) {

    switch (group) {

      case "hidratos":
      case "frutas":
        return const FoodPortions(hc: 1, pr: 0, gr: 0);

      case "legumbres":
        return const FoodPortions(hc: 1, pr: 0.5, gr: 0);

      case "proteina_magra":
        return const FoodPortions(hc: 0, pr: 1, gr: 0);

      case "proteina_grasa_media":
        return const FoodPortions(hc: 0, pr: 1, gr: 0.5);

      case "proteina_grasa_alta":
        return const FoodPortions(hc: 0, pr: 1, gr: 1);

      case "grasas":
        return const FoodPortions(hc: 0, pr: 0, gr: 1);

      case "verduras":
      case "azucares":
        return const FoodPortions(hc: 0.5, pr: 0, gr: 0);

      case "lacteos_desnatados":
        return const FoodPortions(hc: 0.5, pr: 0.5, gr: 0);

      case "lacteos_enteros":
        return const FoodPortions(hc: 0.5, pr: 0.5, gr: 0.5);

      case "otros1":
        return const FoodPortions(hc: 0.5, pr: 1, gr: 1);

      case "otros2":
        return const FoodPortions(hc: 1, pr: 2, gr: 0);
      
      case "otros3":
        return const FoodPortions(hc: 0, pr: 0, gr: 0.25);  

      case "otros4":
        return const FoodPortions(hc: 0, pr: 0.5, gr: 0.5); 

      case "otros5":
        return const FoodPortions(hc: 0.5, pr: 1, gr: 0); 

      case "otros6":
        return const FoodPortions(hc: 0.5, pr: 1, gr: 1); 

      default:
        return const FoodPortions(hc: 0, pr: 0, gr: 0);

    }

  }

}