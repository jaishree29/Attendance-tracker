import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseOptions firebaseOptions = FirebaseOptions(
    apiKey: dotenv.env['APIKEY'].toString(),
    appId: dotenv.env['APPID'].toString(),
    messagingSenderId: dotenv.env['MESSAGINGSENDERID'].toString(),
    projectId: dotenv.env['PROJECTID'].toString(),
  );

  await Firebase.initializeApp(
    options: firebaseOptions,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp();
  }
}
