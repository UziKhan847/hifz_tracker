import 'package:flutter/material.dart';

class DialogMenu {
  DialogMenu({
    this.barrierDismissible = true,
    required this.title,
    required this.content,
    required this.actions,
  });

  final bool barrierDismissible;
  final String title;
  final Widget? content;
  final List<Widget>? actions;

  Future<void> dialogueBuilder(BuildContext context) {
    return showDialog<void>(
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
}
