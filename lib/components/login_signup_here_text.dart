import 'package:flutter/material.dart';

class LoginSignupHereText extends StatelessWidget {
  final String memberQuestionText;
  final String pageChangeText;
  final Function()? onTap;

  const LoginSignupHereText(
      {super.key,
      required this.pageChangeText,
      required this.memberQuestionText,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(memberQuestionText),
        GestureDetector(
          onTap: onTap,
          child: Text(
            pageChangeText,
            style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }
}
