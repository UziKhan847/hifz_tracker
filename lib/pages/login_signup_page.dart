// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:markaz_umaza_hifz_tracker/extensions/context_extensions.dart';
import 'package:markaz_umaza_hifz_tracker/main.dart';
import 'package:markaz_umaza_hifz_tracker/models/login_signup_tile.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class LoginSignupPage extends StatefulWidget {
  LoginSignupPage({super.key});

  @override
  State<LoginSignupPage> createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _pageController = PageController();
  bool _isLoading = false;

  void changePage(int pageNumber) {
    _pageController.animateToPage(
      pageNumber,
      duration: Duration(milliseconds: 450),
      curve: Curves.easeInOut,
    );
  }

  void loadCircle() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  void clearText() {
    _emailController.clear();
    _passwordController.clear();
  }

  Future<void> _login() async {
    try {
      loadCircle();
      await supabase.auth.signInWithPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (mounted) {
        context.showSnackBar("Login Succesful!");
        clearText();
      }
    } on AuthException catch (error) {
      if (mounted) {
        context.showSnackBar(
          error.message,
          isError: true,
        );
      }
    } catch (error) {
      if (mounted) {
        context.showSnackBar(
          'Unexpected error occurred',
          isError: true,
        );
      }
    } finally {
      if (mounted) {
        loadCircle();
      }
    }
  }

  Future<void> _signUp() async {
    try {
      loadCircle();
      await supabase.auth.signUp(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (mounted) {
        context.showSnackBar("Success! Please confirm your account.");
        _emailController.clear();
        _passwordController.clear();
      }
    } on AuthException catch (error) {
      if (mounted) {
        context.showSnackBar(
          error.message,
          isError: true,
        );
      }
    } catch (error) {
      if (mounted) {
        context.showSnackBar(
          'Unexpected error occurred',
          isError: true,
        );
      }
    } finally {
      if (mounted) {
        loadCircle();
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromRGBO(253, 253, 253, 1),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/school_supplies_background.png"),
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
                  SizedBox(
                    height: 30,
                  ),

                  //Logo
                  Image.asset(
                    "images/markaz_umaza_logo.png",
                    height: 100,
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  //Hifz Tracker Text
                  Text(
                    'Hifz Tracker',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  //Main Container
                  Container(
                    height: 325,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                          ),
                          BoxShadow(
                            color: Colors.white.withOpacity(1),
                            spreadRadius: -2,
                            blurRadius: 3,
                            offset: Offset(0, 0),
                          ),
                        ]),
                    child: PageView(
                        controller: _pageController,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          //Login
                          LoginSignupTile(
                            isLoading: _isLoading,
                            forgotPW: GestureDetector(
                                child: Text('Forgot Password?',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w600))),
                            emailController: _emailController,
                            passwordController: _passwordController,
                            buttonText: 'Sign In',
                            onButtonTap: () async {
                              FocusScope.of(context).unfocus();
                              _login();
                            },
                            memberQuestionText: "Not a member yet? ",
                            pageChangeText: "Register here",
                            onTextTap: () {
                              clearText();
                              FocusScope.of(context).unfocus();
                              changePage(1);
                            },
                          ),

                          //SignUp
                          LoginSignupTile(
                            isLoading: _isLoading,
                            emailController: _emailController,
                            passwordController: _passwordController,
                            buttonText: 'Sign Up',
                            onButtonTap: () async {
                              FocusScope.of(context).unfocus();
                              _signUp();
                            },
                            memberQuestionText: "Already a member? ",
                            pageChangeText: "Login here",
                            onTextTap: () {
                              clearText();
                              FocusScope.of(context).unfocus();
                              changePage(0);
                            },
                          ),
                        ]),
                  ),

                  SizedBox(
                    height: 25,
                  ),
                  Image.asset(
                    "images/mushaf_filled.png",
                    height: 70,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
