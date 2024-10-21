import 'package:flutter/material.dart';

class XSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color inactiveThumbColor;

  const XSwitch({
    required this.value,
    required this.onChanged,
    this.activeColor = Colors.blue,
    this.inactiveThumbColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.5, // Scale down the switch to half its size
      child: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: activeColor,
        inactiveThumbColor: inactiveThumbColor,
      ),
    );
  }
}
