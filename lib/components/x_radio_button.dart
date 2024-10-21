import 'package:flutter/material.dart';

class XRadioButton<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;
  final Color activeColor;
  final Color fillColor;

  const XRadioButton({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.activeColor = Colors.blue,
    this.fillColor = Colors.blueAccent,
  });

  @override
  Widget build(BuildContext context) {
    return Radio<T>(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: activeColor,
      fillColor: MaterialStateProperty.all(fillColor),
    );
  }
}
