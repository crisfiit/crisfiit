import 'package:flutter/material.dart';

import '../models/food.dart';
import '../services/favorites_service.dart';
import '../services/food_service.dart';
import 'search_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {

  List<int> favorites = [];
  List<Food> foods = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {

    final data = await FavoritesService.getFavorites();
    final loadedFoods = await FoodService.loadFoods();

    if (!mounted) return;

    setState(() {
      favorites = data;
      foods = loadedFoods;
    });

  }

  Future<void> removeFavorite(int foodId) async {

    await FavoritesService.removeFavorite(foodId);

    loadFavorites();

  }

  void openSearch(int foodId) {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SearchScreen(initialFoodId: foodId),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {

    final validFavorites = favorites
        .map((id) => foods.where((food) => food.id == id).firstOrNull)
        .whereType<Food>()
        .toList();

    return Scaffold(

      appBar: AppBar(
        title: const Text("Favoritos"),
      ),

      body: validFavorites.isEmpty

          ? const Center(child: Text("No hay favoritos aún"))

          : ListView.builder(

              itemCount: validFavorites.length,

              itemBuilder: (context, index) {

                final food = validFavorites[index];

                return ListTile(

                  leading: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),

                  title: Text(food.name),

                  onTap: () => openSearch(food.id),

                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => removeFavorite(food.id),
                  ),

                );

              },

            ),

    );

  }

}