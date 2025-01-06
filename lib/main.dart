import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const GodeGame());
}

class GodeGame extends StatelessWidget {
  const GodeGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gode Game',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AuthScreen(),
    );
  }
}
