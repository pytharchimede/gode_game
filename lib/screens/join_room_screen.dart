import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'game_screen.dart';

class JoinRoomScreen extends StatelessWidget {
  final String roomId;
  const JoinRoomScreen({Key? key, required this.roomId}) : super(key: key);

  Future<void> joinRoom(BuildContext context) async {
    final roomDoc = FirebaseFirestore.instance.collection('rooms').doc(roomId);
    final roomData = await roomDoc.get();

    if (!roomData.exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ce salon n\'existe pas.')),
      );
      return;
    }

    roomDoc.update({
      'players':
          FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
    });

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => GameScreen(roomId: roomId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rejoindre un Salon')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => joinRoom(context),
          child: const Text('Rejoindre le Salon'),
        ),
      ),
    );
  }
}
