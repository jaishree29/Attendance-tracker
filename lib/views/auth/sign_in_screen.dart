import 'package:flutter/material.dart';
import 'package:employee_attendance_tracker/controllers/auth_controller.dart';
import 'package:employee_attendance_tracker/models/role.dart';
import 'package:employee_attendance_tracker/utils/constants/colors.dart';
import 'package:employee_attendance_tracker/pages/admin/admin_panel.dart';
import 'package:employee_attendance_tracker/pages/users/home_page.dart';
import 'package:employee_attendance_tracker/widgets/elevated_button.dart';
import 'package:employee_attendance_tracker/widgets/text_field_input.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthController _authController = AuthController();
  UserRole? _selectedRole; 

  // Sign-In with Email, Password, and Role
  void _handleSignIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty || _selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please fill in all fields and select a role.")),
      );
      return;
    }

    try {
      final user = await _authController.signInWithEmailPassword(
        email,
        password,
        _selectedRole!, 
      );

      if (user != null) {
        if (user.role == UserRole.admin) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AdminPanel(user: user)),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage(user: user)),
          );
        }
      }
    } catch (e) {
      print("Sign-in error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to sign in: ${e.toString()}")),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 100),
                  const Icon(Icons.mail, size: 70),
                  const SizedBox(height: 80),

                  // Email TextField
                  NTextFieldInput(
                    hintText: 'Email',
                    icon: Icons.email,
                    isPhone: false,
                    isPass: false,
                    textController: _emailController,
                  ),

                  // Password TextField
                  NTextFieldInput(
                    hintText: 'Password',
                    icon: Icons.lock,
                    isPhone: false,
                    isPass: true,
                    textController: _passwordController,
                  ),

                  // Role Dropdown
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: DropdownButton<UserRole>(
                      value: _selectedRole,
                      hint: const Text("Select Role"),
                      items: UserRole.values.map((UserRole role) {
                        return DropdownMenuItem<UserRole>(
                          value: role,
                          child: Text(role.toString().split('.').last),
                        );
                      }).toList(),
                      onChanged: (UserRole? newRole) {
                        setState(() {
                          _selectedRole = newRole;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),
              Column(
                children: [
                  // Sign-In Button
                  NElevatedButton(
                    text: 'Sign In',
                    onPressed: _handleSignIn,
                    backgroundColor: FColors.primary,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
