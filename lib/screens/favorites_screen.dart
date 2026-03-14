import 'package:flutter/material.dart';
import '../services/favorites_service.dart';
import 'search_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {

  List<String> favorites = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  void loadFavorites() async {

    final data = await FavoritesService.getFavorites();

    setState(() {
      favorites = data;
    });

  }

  void removeFavorite(String food) async {

    await FavoritesService.removeFavorite(food);

    loadFavorites();

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
        title: const Text("Favoritos"),
      ),

      body: favorites.isEmpty

          ? const Center(child: Text("No hay favoritos aún"))

          : ListView.builder(

              itemCount: favorites.length,

              itemBuilder: (context, index) {

                final food = favorites[index];

                return ListTile(

                  leading: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),

                  title: Text(food),

                  onTap: () => openSearch(food),

                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => removeFavorite(food),
                  ),

                );

              },

            ),

    );

  }

}