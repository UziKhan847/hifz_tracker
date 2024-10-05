import 'package:flutter/material.dart';

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    super.key,
    required this.label,
    required this.padding,
    required this.value,
    required this.onChanged,
  });

  final Text label;
  final EdgeInsets padding;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(child: label),
            SizedBox(
              height: 25,
              child: Checkbox(
                value: value,
                onChanged: (bool? newValue) {
                  onChanged(newValue!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
