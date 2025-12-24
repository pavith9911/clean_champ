import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("main 6");
  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: "AIzaSyBIP4WDoldfVNWQdweB0r313i8taBWzXWA", appId:  "1:889716849306:android:43055c4f0efd0923a47d23", messagingSenderId: "pavith", projectId: "clean-champ-c754a")
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
