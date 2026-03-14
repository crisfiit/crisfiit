import 'package:flutter/material.dart';
import '../services/history_service.dart';
import 'search_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  List<String> history = [];

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  void loadHistory() async {

    final data = await HistoryService.getHistory();

    setState(() {
      history = data;
    });

  }

  void clearHistory() async {

    await HistoryService.clearHistory();

    loadHistory();

  }

  void openSearch(String food) {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SearchScreen(initialFood: food),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {

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

      body: history.isEmpty

          ? const Center(child: Text("Historial vacío"))

          : ListView.builder(

              itemCount: history.length,

              itemBuilder: (context, index) {

                final food = history[index];

                return ListTile(

                  leading: const Icon(Icons.history),

                  title: Text(food),

                  onTap: () => openSearch(food),

                );

              },

            ),

    );

  }

}