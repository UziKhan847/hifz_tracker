import 'package:flutter/material.dart';

class LoginSignupTextfield extends StatelessWidget {
  final bool isObscure;
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;


  const LoginSignupTextfield({super.key, required this.isObscure, required this.hintText, required this.controller, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: controller,
        obscureText: isObscure,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Color.fromARGB(255, 200, 200, 200), fontSize: 14),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFe19a25)),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF17588b)),
            borderRadius: BorderRadius.circular(8),
          )
       ),),
     );
  }
}