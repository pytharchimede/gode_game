import 'package:flutter/material.dart';

class DiceWidget extends StatefulWidget {
  const DiceWidget({Key? key}) : super(key: key);

  @override
  _DiceWidgetState createState() => _DiceWidgetState();
}

class _DiceWidgetState extends State<DiceWidget> {
  int dice1 = 1;
  int dice2 = 1;

  void rollDice() {
    setState(() {
      dice1 = (1 +
          (6 * (new DateTime.now().millisecondsSinceEpoch % 1000) / 1000)
              .toInt());
      dice2 = (1 +
          (6 * (new DateTime.now().millisecondsSinceEpoch % 1000) / 1000)
              .toInt());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/dice$dice1.png', width: 100, height: 100),
            const SizedBox(width: 20),
            Image.asset('assets/dice$dice2.png', width: 100, height: 100),
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: rollDice,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Lancer les Dés',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}
