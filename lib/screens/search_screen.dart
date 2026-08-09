import 'package:flutter/material.dart';

import '../models/food.dart';
import '../services/food_service.dart';
import '../services/equivalence_service.dart';
import '../services/favorites_service.dart';
import '../services/history_service.dart';
import '../utils/category_icon.dart';
import '../utils/text_utils.dart';

class SearchScreen extends StatefulWidget {
  final int? initialFoodId;

  const SearchScreen({super.key, this.initialFoodId});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  List<Food> foods = [];
  List<Food> filteredFoods = [];
  List<int> favorites = [];

  Food? selectedFood;

  List<Map<String, dynamic>> equivalences = [];

  FoodPortions? portions;

  final TextEditingController searchController = TextEditingController();
  final TextEditingController gramsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {

    final loadedFoods = await FoodService.loadFoods();
    final favs = await FavoritesService.getFavorites();

    if (!mounted) return;

    setState(() {
      foods = loadedFoods;
      favorites = favs;
      filteredFoods = [];
    });

    if (widget.initialFoodId != null) {

      final match = foods.firstWhere(
        (food) => food.id == widget.initialFoodId,
        orElse: () => foods.first,
      );

      if (!mounted) return;

      setState(() {
        selectedFood = match;
        searchController.text = match.name;
        filteredFoods = [];
      });

      calculate();
    }
  }

  void filterFoods(String query) {

    if (selectedFood != null) {
      setState(() {
        selectedFood = null;
        equivalences = [];
        portions = null;
      });
    }

    if (query.isEmpty) {
      setState(() {
        filteredFoods = [];
      });
      return;
    }

    final normalizedQuery = TextUtils.normalize(query.trim());

    final results = foods.where((food) {

      final normalizedName = TextUtils.normalize(food.name);

      final words = normalizedName.split(" ");

      return words.any((word) => word.startsWith(normalizedQuery)) ||
          normalizedName.contains(normalizedQuery);

    }).toList();

    setState(() {
      filteredFoods = results;
    });

  }

  Future<void> toggleFavorite(int foodId) async {

    if (favorites.contains(foodId)) {
      await FavoritesService.removeFavorite(foodId);
    } else {
      await FavoritesService.addFavorite(foodId);
    }

    final favs = await FavoritesService.getFavorites();

    if (!mounted) return;

    setState(() {
      favorites = favs;
    });
  }

  Future<void> selectFood(Food food) async {

    await HistoryService.addHistory(food.id);

    if (!mounted) return;

    setState(() {
      selectedFood = food;
      searchController.text = food.name;
      filteredFoods = [];
      equivalences = [];
      portions = null;
    });

    FocusScope.of(context).unfocus();

    calculate();
  }

  void calculate() {

    if (selectedFood == null) return;

    final grams = double.tryParse(gramsController.text);
    if (grams == null) return;

    final sameGroupFoods = foods
        .where((food) =>
            food.group == selectedFood!.group &&
            food.name != selectedFood!.name)
        .toList();

    final results =
        EquivalenceService.calculate(selectedFood!, grams, sameGroupFoods);

    setState(() {
      equivalences = results["equivalences"];
      portions = results["portions"];
    });
  }

  Widget buildFoodList() {

    if (filteredFoods.isEmpty) {
      return const SizedBox();
    }

    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: filteredFoods.length,
        itemBuilder: (context, index) {

          final food = filteredFoods[index];
          final isFavorite = favorites.contains(food.id);

          return ListTile(
            leading: getCategoryIcon(food.category),
            title: Text(food.name),
            trailing: IconButton(
              icon: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                color: isFavorite ? Colors.amber : Colors.grey,
              ),
              onPressed: () => toggleFavorite(food.id),
            ),
            onTap: () => selectFood(food),
          );
        },
      ),
    );
  }

  Widget buildEquivalencesList() {

    if (equivalences.isEmpty) {
      return const SizedBox();
    }

    return Expanded(
      child: ListView.builder(
        itemCount: equivalences.length,
        itemBuilder: (context, index) {

          final item = equivalences[index];

          final Food food = item["food"];
          final double grams = item["grams"];

          final isFavorite = favorites.contains(food.id);

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF1F2A24)
                  : Colors.green.shade50,
            ),
            child: Row(
              children: [

                getCategoryIcon(food.category),

                const SizedBox(width: 10),

                Expanded(
                  child: Text(
                    food.name,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).brightness ==
                              Brightness.dark
                          ? Colors.white
                          : Colors.black87,
                    ),
                  ),
                ),

                Text(
                  "${grams.toStringAsFixed(0)} g",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(width: 10),

                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.star : Icons.star_border,
                    color: isFavorite ? Colors.amber : Colors.grey,
                  ),
                  onPressed: () => toggleFavorite(food.id),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildPortionChip(String label, double value) {

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF2E3A33)
            : Colors.green.shade100,
      ),
      child: Text(
        "${value.toStringAsFixed(1)} $label",
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildPortions() {

    if (portions == null) return const SizedBox();

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [

            const Text(
              "Raciones equivalentes",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 8,
              children: [

                buildPortionChip("HC", portions!.hc),
                buildPortionChip("PR", portions!.pr),
                buildPortionChip("GR", portions!.gr),

              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Buscar alimento"),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Buscar alimento",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onChanged: filterFoods,
              ),

              const SizedBox(height: 12),

              TextField(
                controller: gramsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Gramos",
                  prefixIcon: const Icon(Icons.scale),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onChanged: (value) => calculate(),
              ),

              const SizedBox(height: 16),

              buildFoodList(),

              const SizedBox(height: 10),

              buildEquivalencesList(),

              buildPortions(),

            ],
          ),
        ),
      ),
    );
  }
}