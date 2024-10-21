import 'package:flutter/material.dart';

class XCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final Color checkColor;
  final Color activeColor;
  final Color checkBoxBorderColor;

  const XCheckbox({
    required this.value,
    required this.onChanged,
    this.checkColor = Colors.white,
    this.activeColor = Colors.blue,
    this.checkBoxBorderColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: onChanged,
      checkColor: checkColor,
      activeColor: activeColor,
      side: BorderSide(color: checkBoxBorderColor),
    );
  }
}
  