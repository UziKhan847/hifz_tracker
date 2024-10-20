import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  void showSnackBar(String message, {bool isError = false}) =>
      ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor:
              isError ? const Color(0xFF8A241D) : const Color(0xFF187218),
          duration: Duration(milliseconds: 2500),
        ),
      );

  void dialog(
          {bool barrierDismissible = true,
          required String title,
          Widget? content,
          List<Widget>? actions,
          required BuildContext context}) =>
      showDialog<void>(
          barrierDismissible: barrierDismissible,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              content: content,
              actions: actions,
            );
          });
}
