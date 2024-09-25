import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            isError ? const Color(0xFF8A241D) : const Color(0xFF187218),
        duration: Duration(milliseconds: 2500),
      ),
    );
  }
}
