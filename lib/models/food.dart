class Food {

  final int id;
  final String name;
  final int grams;
  final String category;
  final String group;

  Food({
    required this.id,
    required this.name,
    required this.grams,
    required this.category,
    required this.group,
  });

  factory Food.fromJson(Map<String, dynamic> json) {

    return Food(
      id: json["id"],
      name: json["name"],
      grams: json["grams"],
      category: json["category"],
      group: json["group"],
    );

  }

}

class FoodPortions {

  final double hc;
  final double pr;
  final double gr;

  const FoodPortions({
    required this.hc,
    required this.pr,
    required this.gr,
  });

}
