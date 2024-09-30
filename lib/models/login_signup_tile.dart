// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../utils/margins.dart';
import '../widgets/login/login_signup_button.dart';
import '../widgets/login/login_signup_here_text.dart';
import '../widgets/login/login_signup_textfield.dart';

class LoginSignupTile extends StatelessWidget {
  const LoginSignupTile({
    super.key,
    this.forgotPW,
    required this.emailController,
    required this.passwordController,
    required this.buttonText,
    required this.onButtonTap,
    required this.onTextTap,
    required this.pageChangeText,
    required this.memberQuestionText,
    required this.isLoading,
  });

  final Widget? forgotPW;
  final bool isLoading;
  final String buttonText;
  final String pageChangeText;
  final String memberQuestionText;
  final Function()? onButtonTap;
  final Function()? onTextTap;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    TextStyle bold = TextStyle(fontWeight: FontWeight.w700, fontSize: 15);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //Email
            children: [
              Text(
                'Email:',
                style: bold,
              ),
              SizedBox(
                height: 3,
              ),
              LoginSignupTextfield(
                isObscure: false,
                controller: emailController,
                hintText: 'example@example.com',
                keyboardType: TextInputType.emailAddress,
              ),

              SizedBox(
                height: 12,
              ),

              //Password
              Text(
                'Password:',
                style: bold,
              ),
              SizedBox(
                height: 3,
              ),
              LoginSignupTextfield(
                isObscure: true,
                controller: passwordController,
                hintText: '********',
              ),
            ],
          ),

          SizedBox(height: 20),
          LoginSignupButton(
            buttonText: buttonText,
            onTap: onButtonTap,
            isLoading: isLoading,
          ),

          //forgot password text
          SizedBox(height: 15),
          if (forgotPW != null) forgotPW!,

          Margins.vertical10,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(memberQuestionText),
              LoginSignupHereText(
                text: pageChangeText,
                onTap: onTextTap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
