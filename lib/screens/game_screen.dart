import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Ajout de l'import FirebaseAuth
import 'package:gode_game/widgets/dice_widget.dart';

class GameScreen extends StatefulWidget {
  final String roomId;
  const GameScreen({Key? key, required this.roomId}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Stream<DocumentSnapshot> roomStream;
  int turnIndex = 0;
  bool gameEnded = false;
  List<Map<String, dynamic>> players = [];
  List<int> rolls = [];

  @override
  void initState() {
    super.initState();
    roomStream = FirebaseFirestore.instance
        .collection('rooms')
        .doc(widget.roomId)
        .snapshots();
  }

  void updatePlayerStats(int playerIndex, int roll1, int roll2) {
    int total = roll1 + roll2;
    setState(() {
      rolls[playerIndex] = total;
      if (gameEnded) return;
      checkGameStatus();
    });

    FirebaseFirestore.instance.collection('rooms').doc(widget.roomId).update({
      'players': players,
    });
  }

  void checkGameStatus() {
    // Compare les résultats des joueurs et déterminer le gagnant
    var maxRoll = rolls.reduce((a, b) => a > b ? a : b);
    List<int> winners = [];
    for (int i = 0; i < rolls.length; i++) {
      if (rolls[i] == maxRoll) {
        winners.add(i);
      }
    }

    if (winners.length == 1) {
      // Calcul des gains
      int winnerIndex = winners.first;
      int betAmount = players[winnerIndex]['bet'];
      int totalPlayers = players.length;
      players[winnerIndex]['balance'] += (betAmount * totalPlayers) - betAmount;
    } else {
      // Partie supplémentaire si égalité
      setState(() {
        gameEnded = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Partie en cours')),
      body: StreamBuilder<DocumentSnapshot>(
        stream: roomStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          final roomData = snapshot.data!;
          players = List<Map<String, dynamic>>.from(roomData['players']);
          rolls = List<int>.filled(players.length, 0);

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: players.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                          'Joueur ${index + 1}: ${players[index]['balance']}'),
                    );
                  },
                ),
              ),
              DiceWidget(
                playerIndex: turnIndex,
                isMyTurn: turnIndex ==
                    FirebaseAuth.instance.currentUser!.uid, // Modification ici
                onRoll: (roll1, roll2) {
                  updatePlayerStats(turnIndex, roll1, roll2);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
