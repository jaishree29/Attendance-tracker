import 'package:employee_attendance_tracker/pages/auth/phoneauth.dart';
import 'package:employee_attendance_tracker/utils/constants/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  String envFilePath = '.env';

  await dotenv.load(fileName: envFilePath);
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: FColors.primary),
      child: MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        debugShowCheckedModeBanner: false,
        home: const PhoneAuth(),
      ),
    );
  }
}
