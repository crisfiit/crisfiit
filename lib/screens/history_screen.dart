import 'package:flutter/material.dart';

import '../models/food.dart';
import '../services/history_service.dart';
import '../services/food_service.dart';
import 'search_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  List<int> history = [];
  List<Food> foods = [];

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {

    final data = await HistoryService.getHistory();
    final loadedFoods = await FoodService.loadFoods();

    if (!mounted) return;

    setState(() {
      history = data;
      foods = loadedFoods;
    });

  }

  Future<void> clearHistory() async {

    await HistoryService.clearHistory();

    if (!mounted) return;

    loadHistory();

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

    final validHistory = history
        .map((id) => foods.where((food) => food.id == id).firstOrNull)
        .whereType<Food>()
        .toList();

    return Scaffold(

      appBar: AppBar(

        title: const Text("Historial"),

        actions: [

          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: clearHistory,
          )

        ],

      ),

      body: validHistory.isEmpty

          ? const Center(child: Text("Historial vacío"))

          : ListView.builder(

              itemCount: validHistory.length,

              itemBuilder: (context, index) {

                final food = validHistory[index];

                return ListTile(

                  leading: const Icon(Icons.history),

                  title: Text(food.name),

                  onTap: () => openSearch(food.id),

                );

              },

            ),

    );

  }

}