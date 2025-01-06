import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'join_room_screen.dart';

class CreateRoomScreen extends StatelessWidget {
  const CreateRoomScreen({Key? key}) : super(key: key);

  Future<void> createRoom(
      BuildContext context, String roomName, double bet, int maxPlayers) async {
    final roomId = FirebaseFirestore.instance.collection('rooms').doc().id;

    await FirebaseFirestore.instance.collection('rooms').doc(roomId).set({
      'roomName': roomName,
      'bet': bet,
      'maxPlayers': maxPlayers,
      'players': [],
    });

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => JoinRoomScreen(roomId: roomId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController roomNameController = TextEditingController();
    final TextEditingController betController = TextEditingController();
    final TextEditingController maxPlayersController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Créer un Salon')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: roomNameController,
              decoration: const InputDecoration(labelText: 'Nom du Salon'),
            ),
            TextField(
              controller: betController,
              decoration: const InputDecoration(labelText: 'Mise (XOF)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: maxPlayersController,
              decoration: const InputDecoration(labelText: 'Nombre de Joueurs'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final roomName = roomNameController.text;
                final bet = double.parse(betController.text);
                final maxPlayers = int.parse(maxPlayersController.text);

                createRoom(context, roomName, bet, maxPlayers);
              },
              child: const Text('Créer le Salon'),
            ),
          ],
        ),
      ),
    );
  }
}
