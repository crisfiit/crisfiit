import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const CrisfiitApp());

}

class CrisfiitApp extends StatelessWidget {
  const CrisfiitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Crisfiit",
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF279875),
      ),

      darkTheme: ThemeData.dark(),

      home: const HomeScreen(),
    );
  }
}