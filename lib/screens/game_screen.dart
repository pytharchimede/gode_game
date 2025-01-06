import 'package:flutter/material.dart';
import '../widgets/dice_widget.dart';
import '../widgets/player_list_widget.dart';

class GameScreen extends StatelessWidget {
  final String roomId;
  const GameScreen({Key? key, required this.roomId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Partie en cours')),
      body: Column(
        children: [
          Expanded(child: PlayerListWidget(roomId: roomId)),
          const SizedBox(height: 20),
          const DiceWidget(),
        ],
      ),
    );
  }
}
