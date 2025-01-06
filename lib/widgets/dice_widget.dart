import 'dart:math';
import 'package:flutter/material.dart';

class DiceWidget extends StatefulWidget {
  final int playerIndex;
  final bool isMyTurn;
  final Function(int, int) onRoll;

  const DiceWidget({
    Key? key,
    required this.playerIndex,
    required this.isMyTurn,
    required this.onRoll,
  }) : super(key: key);

  @override
  _DiceWidgetState createState() => _DiceWidgetState();
}

class _DiceWidgetState extends State<DiceWidget> {
  int dice1 = 1;
  int dice2 = 1;
  bool rolling = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image de fond
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Les dés affichés
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/dice$dice1.png', width: 100, height: 100),
            const SizedBox(width: 20),
            Image.asset('assets/dice$dice2.png', width: 100, height: 100),
          ],
        ),
        const SizedBox(height: 20),
        // Bouton Lancer les Dés
        ElevatedButton(
          onPressed: widget.isMyTurn && !rolling
              ? () {
                  setState(() {
                    rolling = true;
                  });
                  // Animation de lancer
                  Future.delayed(const Duration(milliseconds: 500), () {
                    int roll1 = Random().nextInt(6) + 1;
                    int roll2 = Random().nextInt(6) + 1;
                    setState(() {
                      dice1 = roll1;
                      dice2 = roll2;
                      rolling = false;
                    });
                    widget.onRoll(roll1, roll2);
                  });
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.isMyTurn ? Colors.blue : Colors.grey,
          ),
          child: const Text('Lancer les Dés'),
        ),
      ],
    );
  }
}
