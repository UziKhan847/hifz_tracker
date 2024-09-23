// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:markaz_umaza_hifz_tracker/models/login_signup_tile.dart';

class LoginSignupPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final PageController _pageController = PageController();
  final bool isLoading = false;

  LoginSignupPage({super.key});


  void changePage(int pageNumber) {
    _pageController.animateToPage(
    pageNumber,
    duration: Duration(milliseconds: 400),
    curve: Curves.easeInOut,
  );
  }

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      backgroundColor: Color.fromRGBO(253, 253, 253, 1),
      body: Container(
        height: double.infinity,
        width: double.infinity,
         decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/images/school_supplies_background.png"),
            fit: BoxFit.cover,
          ),
      ),
      child: SafeArea(
        left: false,
        right: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            children: [
              SizedBox(height: 30,),

              //Logo
              Image.asset("lib/images/markaz_umaza_logo.png", height: 100,),
              SizedBox(height: 20,),

              //Hifz Tracker Text
              Text('Hifz Tracker', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),),
              SizedBox(height: 20,),

              //Main Container
              Container(
                height: 325,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.14)
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(1),
                     spreadRadius: -2,
                      blurRadius: 3,
                      offset: Offset(0, 0),),
                  ]
                ),
                child: PageView(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    LoginSignupTile(
                    forgotPW: GestureDetector(child: Text('Forgot Password?', style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontWeight: FontWeight.w600))),
                    emailController: _emailController,
                    passwordController: _passwordController,
                    buttonText: 'Sign In',
                    onButtonTap: (){},
                    memberQuestionText: "Not a member yet? ",
                    pageChangeText: "Register here",
                    onTextTap: () {changePage(1);},
                  ),
                  LoginSignupTile(
                    emailController: _emailController,
                    passwordController: _passwordController,
                    buttonText: 'Sign Un',
                    onButtonTap: (){},
                    memberQuestionText: "Already a member? ",
                    pageChangeText: "Login here",
                    onTextTap: () {changePage(0);},
                  ),
                  ]
                ),
              ),

              SizedBox(height: 25,),
              Image.asset("lib/images/mushaf_filled.png", height: 80,),

            ],
          ),
        ),
      ),
    ),);
  }
}