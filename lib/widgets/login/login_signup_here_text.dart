import 'package:flutter/material.dart';

class LoginSignupHereText extends StatelessWidget {
  final String text;
  final Function()? onTap;

  const LoginSignupHereText(
      {super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
