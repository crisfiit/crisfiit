import 'package:flutter/material.dart';
import '../models/food.dart';
import '../services/equivalence_service.dart';

class ResultsScreen extends StatelessWidget {

  final Food food;
  final double grams;
  final List<Food> foods;

  const ResultsScreen({
    super.key,
    required this.food,
    required this.grams,
    required this.foods,
  });

  @override
  Widget build(BuildContext context) {

    final result =
        EquivalenceService.calculate(food, grams, foods);

    final List equivalences = result["equivalences"];
    final portions = result["portions"];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Equivalencias"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Equivalencias en gramos",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: equivalences.length,
                itemBuilder: (context, index) {

                  final item = equivalences[index];
                  final Food eqFood = item["food"];
                  final double g = item["grams"];

                  return ListTile(
                    title: Text(eqFood.name),
                    trailing: Text("${g.toStringAsFixed(0)} g"),
                  );

                },
              ),
            ),

            const Divider(),

            const SizedBox(height: 10),

            const Text(
              "Raciones equivalentes",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                _portionBox("HC", portions.hc),
                _portionBox("PR", portions.pr),
                _portionBox("GR", portions.gr),

              ],
            )

          ],
        ),
      ),
    );
  }

  Widget _portionBox(String label, double value) {

    return Column(
      children: [

        Text(
          value.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 4),

        Text(label)

      ],
    );

  }

}