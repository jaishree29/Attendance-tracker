import 'package:employee_attendance_tracker/views/auth/sign_in_screen.dart';
import 'package:employee_attendance_tracker/widgets/elevated_button.dart';
import 'package:employee_attendance_tracker/widgets/text_field_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          NTextFieldInput(
            hintText: 'Enter OTP',
            icon: Icons.verified_user,
            isPass: false,
            textController: otpController,
            isPhone: true,
          ),
          const SizedBox(
            height: 30,
          ),
          NElevatedButton(
              text: 'Confirm',
              onPressed: () async {
                try {
                  PhoneAuthCredential credential =
                      PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: otpController.text.toString(),
                  );
                  FirebaseAuth.instance
                      .signInWithCredential(credential)
                      .then((value) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInScreen(),
                      ),
                    );
                  });
                } catch (ex) {
                  print(ex.toString());
                }
              })
        ],
      ),
    );
  }
}
