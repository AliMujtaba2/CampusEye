import 'package:campuseyeapp/Resources/auth.dart';
import 'package:flutter/material.dart';
import 'resources/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures binding before initializing Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Campus Eye',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  AuthPage(), // SplashScreen is the first screen
    );
  }
}
