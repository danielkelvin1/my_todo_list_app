import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mytodolist/screen/intro_screen.dart';
import 'package:mytodolist/screen/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Todo List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          background: const Color(
            0xfff1f5f9,
          ),
        ),
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      home: const IntroScreen(),
    );
  }
}
