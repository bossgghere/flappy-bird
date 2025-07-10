import 'package:birdgame/game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to game screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => GameWidget(game: FlappyBirdGame()),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green, // Full green background
      body: Center(
        child: Text(
          'Flappy Bird',
          style: TextStyle(
            color: Colors.white,
            fontSize: 48,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}
