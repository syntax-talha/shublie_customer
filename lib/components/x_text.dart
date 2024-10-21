import 'package:flutter/material.dart';

class XText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final TextOverflow? overflow; // Add overflow as a named parameter

  const XText({
    required this.text,
    this.fontSize,
    this.color,
    this.overflow, // Initialize overflow
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow, // Apply overflow
      style: TextStyle(
        fontSize: fontSize ?? 14.0,
        color: color ?? Colors.black,
      ),
    );
  }
}
