import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PlayerListWidget extends StatelessWidget {
  final String roomId;
  const PlayerListWidget({Key? key, required this.roomId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('rooms')
          .doc(roomId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const CircularProgressIndicator();

        final players = snapshot.data!['players'] as List<dynamic>;

        return ListView.builder(
          itemCount: players.length,
          itemBuilder: (context, index) => ListTile(
            title: Text('Joueur ${index + 1}'),
          ),
        );
      },
    );
  }
}
