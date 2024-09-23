// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:markaz_umaza_hifz_tracker/components/login_signup_button.dart';
import 'package:markaz_umaza_hifz_tracker/components/login_signup_here_text.dart';
import 'package:markaz_umaza_hifz_tracker/components/login_signup_textfield.dart';

class LoginSignupTile extends StatelessWidget {
  final Widget? forgotPW;
  final String buttonText;
  final String pageChangeText;
  final String memberQuestionText;
  final Function()? onButtonTap;
  final Function()? onTextTap;
  final TextEditingController emailController;
  final TextEditingController passwordController;


  const LoginSignupTile({super.key,
  this.forgotPW,
  required this.emailController,
  required this.passwordController,
  required this.buttonText,
  required this.onButtonTap,
  required this.onTextTap,
  required this.pageChangeText,
  required this.memberQuestionText,});

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
                          Text('Email:', style: bold,),
                          SizedBox(height: 3,),
                          LoginSignupTextfield(
                            isObscure: false,
                            controller: emailController,
                            hintText: 'example@example.com',
                            keyboardType: TextInputType.emailAddress,
                          ),
      
                        SizedBox(height: 12,),
      
                        //Password
                        Text('Password:', style: bold,),
                        SizedBox(height: 3,),
                        LoginSignupTextfield(
                            isObscure: true,
                            controller: passwordController,
                            hintText: '********',
                          ),
                        ],
                      ),
      
                      SizedBox(height: 20,),
                      LoginSignupButton(
                        buttonText: buttonText,
                        onTap: onButtonTap,
                      ),
      
                      //forgot password text
                      SizedBox(height: 15,),
                      Container(
                        child: forgotPW
                      ),
      
                      SizedBox(height: 10,),
                      LoginSignupHereText(pageChangeText: pageChangeText, memberQuestionText: memberQuestionText, onTap: onTextTap),
                    ],
                  ),
    );
  }
}