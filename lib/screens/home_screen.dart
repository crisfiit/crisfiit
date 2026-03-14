import 'package:flutter/material.dart';
import 'search_screen.dart';
import 'favorites_screen.dart';
import 'history_screen.dart';
import 'package:crisfiit/widgets/crisfiit_logo.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
      ),

      body: SafeArea(
      child: Center(
        child: Padding(

          padding: const EdgeInsets.all(24),

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              const CrisfiitLogo(height: 160),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton.icon(

                  icon: const Icon(Icons.search),

                  label: const Text(
                    "Buscar alimento",
                    style: TextStyle(fontSize: 18),
                  ),

                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SearchScreen(),
                      ),
                    );

                  },

                ),

              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton.icon(

                  icon: const Icon(Icons.star),

                  label: const Text(
                    "Favoritos",
                    style: TextStyle(fontSize: 18),
                  ),

                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const FavoritesScreen(),
                      ),
                    );

                  },

                ),

              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton.icon(

                  icon: const Icon(Icons.history),

                  label: const Text(
                    "Historial",
                    style: TextStyle(fontSize: 18),
                  ),

                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HistoryScreen(),
                      ),
                    );

                  },

                ),

              ),

              const Spacer(),

              const SizedBox(height: 4),

              const Text(
                "© 2026 Crisfiit - created by aru_baro & crisfiit",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),

            ],

          ),

        ),

      ),

    )
  );
  }

}