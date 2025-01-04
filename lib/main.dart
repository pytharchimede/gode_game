import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(GodeGameApp());

class GodeGameApp extends StatelessWidget {
  const GodeGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GodeGame(),
    );
  }
}

class GodeGame extends StatefulWidget {
  const GodeGame({super.key});

  @override
  _GodeGameState createState() => _GodeGameState();
}

class _GodeGameState extends State<GodeGame> {
  final Random random = Random();
  int player1Dice1 = 1;
  int player1Dice2 = 1;
  int player2Dice1 = 1;
  int player2Dice2 = 1;

  int player1Score = 0;
  int player2Score = 0;
  int cagnotte = 100;

  String winner = "";

  void rollDice() {
    setState(() {
      // Lancer les dés pour les deux joueurs
      player1Dice1 = random.nextInt(6) + 1;
      player1Dice2 = random.nextInt(6) + 1;
      player2Dice1 = random.nextInt(6) + 1;
      player2Dice2 = random.nextInt(6) + 1;

      // Calcul des scores
      player1Score = player1Dice1 + player1Dice2;
      player2Score = player2Dice1 + player2Dice2;

      // Déterminer le gagnant
      if (player1Score > player2Score) {
        winner = "Joueur 1 gagne!";
        cagnotte += 10;
      } else if (player2Score > player1Score) {
        winner = "Joueur 2 gagne!";
        cagnotte += 10;
      } else {
        winner = "Égalité ! Relancez les dés.";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jeu de Godé"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Cagnotte : $cagnotte", style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text("Joueur 1", style: TextStyle(fontSize: 18)),
                  Image.asset('assets/dice$player1Dice1.png',
                      width: 80, height: 80),
                  Image.asset('assets/dice$player1Dice2.png',
                      width: 80, height: 80),
                  Text("Score : $player1Score",
                      style: const TextStyle(fontSize: 16)),
                ],
              ),
              Column(
                children: [
                  const Text("Joueur 2", style: TextStyle(fontSize: 18)),
                  Image.asset('assets/dice$player2Dice1.png',
                      width: 80, height: 80),
                  Image.asset('assets/dice$player2Dice2.png',
                      width: 80, height: 80),
                  Text("Score : $player2Score",
                      style: const TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: rollDice,
            child: const Text("Lancer les dés"),
          ),
          const SizedBox(height: 20),
          Text(
            winner,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
