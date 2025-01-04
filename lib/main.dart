import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() {
  runApp(const GodeGame());
}

class GodeGame extends StatelessWidget {
  const GodeGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DiceGame(),
    );
  }
}

class DiceGame extends StatefulWidget {
  @override
  _DiceGameState createState() => _DiceGameState();
}

class _DiceGameState extends State<DiceGame> {
  int dice1 = 1;
  int dice2 = 1;
  bool isRolling = false;

  void rollDice() async {
    setState(() {
      isRolling = true;
    });

    // Simuler l'animation du dé
    for (int i = 0; i < 10; i++) {
      await Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          dice1 = Random().nextInt(6) + 1;
          dice2 = Random().nextInt(6) + 1;
        });
      });
    }

    setState(() {
      isRolling = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fond immersif
          Positioned.fill(
            child: Image.asset(
              'assets/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Dés avec animation
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Animate(
                      effects: [
                        ShimmerEffect(),
                        const RotateEffect(
                            duration: Duration(milliseconds: 500))
                      ],
                      child: Image.asset(
                        'assets/dice$dice1.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Animate(
                      effects: [
                        const FlipEffect(duration: Duration(milliseconds: 500)),
                      ],
                      child: Image.asset(
                        'assets/dice$dice2.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                // Bouton de lancer
                ElevatedButton(
                  onPressed: isRolling ? null : rollDice,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    backgroundColor: Colors.amber,
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text("Lancer les dés"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
