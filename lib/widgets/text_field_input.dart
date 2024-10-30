import 'package:flutter/material.dart';

class NTextFieldInput extends StatelessWidget {
  const NTextFieldInput({
    super.key,
    required this.hintText,
    required this.icon,
    required this.isPass,
    required this.textController,
    required this.isPhone,
  });

  final TextEditingController textController;
  final bool isPass;
  final bool isPhone;
  final String hintText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: TextFormField(
        controller: textController,
        obscureText: isPass,
        keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 20),
          icon: Icon(icon),
        ),
      ),
    );
  }
}
