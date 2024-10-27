import 'dart:async';

import 'package:employee_attendance_tracker/models/role.dart';
import 'package:employee_attendance_tracker/models/user_model.dart';
import 'package:employee_attendance_tracker/navigation_page.dart';
import 'package:employee_attendance_tracker/utils/constants/colors.dart';
import 'package:employee_attendance_tracker/views/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Assuming you have UserModel with a UserRole enum
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static const String KEYLOGIN = 'Login';
  static const String KEYUSERROLE = 'UserRole'; 

  @override
  void initState() {
    super.initState();
    whereToGo();
  }

  Future<void> whereToGo() async {
    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getBool(KEYLOGIN) ?? false;
    var userRoleString = sharedPref.getString(KEYUSERROLE);

    Timer(const Duration(seconds: 3), () {
      if (isLoggedIn) {
        UserRole userRole;
        switch (userRoleString) {
          case 'admin':
            userRole = UserRole.admin;
            break;
          case 'guardEmployee':
            userRole = UserRole.guardEmployee;
            break;
          case 'supervisorEmployee':
            userRole = UserRole.supervisorEmployee;
            break;
          default:
            userRole = UserRole.generalEmployee;
            break;
        }

        final user = UserModel(
            role: userRole); 
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => NavigationPage(user: user),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignInScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: FColors.primary,
      body: Center(
        child: Text(
          'Force 2',
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
