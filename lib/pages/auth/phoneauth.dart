import 'package:employee_attendance_tracker/pages/auth/otp.dart';
import 'package:employee_attendance_tracker/widgets/elevated_button.dart';
import 'package:employee_attendance_tracker/widgets/text_field_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Auth'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NTextFieldInput(
            hintText: 'Phone',
            icon: Icons.phone,
            isPass: false,
            isPhone: true,
            textController: phoneController,
          ),
          const SizedBox(
            height: 30,
          ),
          NElevatedButton(
            text: 'Verify',
            onPressed: () async {
              await FirebaseAuth.instance.verifyPhoneNumber(
                verificationCompleted: (PhoneAuthCredential credential) {},
                verificationFailed: (FirebaseAuthException exception) {},
                codeSent: (String verificationId, int? resendToken) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OtpScreen(
                        verificationId: verificationId,
                      ),
                    ),
                  );
                },
                codeAutoRetrievalTimeout: (String verificationID) {},
                phoneNumber: phoneController.text.toString(),
              );
            },
          ),
        ],
      ),
    );
  }
}
