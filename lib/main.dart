import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const DotsAndBoxesApp());
}

class DotsAndBoxesApp extends StatelessWidget {
  const DotsAndBoxesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dots & Boxes',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF101A46),
      ),
      home: const WelcomeScreen(),
    );
  }
}