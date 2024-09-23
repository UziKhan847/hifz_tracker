import 'package:flutter/material.dart';

class LoginSignupButton extends StatelessWidget {
final String buttonText;
final Function()? onTap; 

  const LoginSignupButton({super.key, required this.buttonText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xFF17588b),
          ),
            child: Center(child: Text(buttonText, style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.w500)),),
        ),
    );
  }
}