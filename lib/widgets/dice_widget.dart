import 'package:flutter/material.dart';

class DiceWidget extends StatelessWidget {
  const DiceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/dice.png', width: 100, height: 100),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Lancer les Dés'),
        ),
      ],
    );
  }
}
