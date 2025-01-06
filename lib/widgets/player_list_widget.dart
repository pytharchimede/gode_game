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
          itemBuilder: (context, index) => Card(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            color: Colors.white.withOpacity(0.8),
            child: ListTile(
              title: Text(
                'Joueur ${index + 1}',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              subtitle:
                  Text('Mise: XOF 1000', style: TextStyle(color: Colors.blue)),
              trailing: Text(
                'Gain: XOF 2000',
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }
}
