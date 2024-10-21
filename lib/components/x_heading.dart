import 'package:flutter/material.dart';

class XHeading extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight; // Add fontWeight as a named parameter

  const XHeading({
    required this.text,
    this.fontSize,
    this.color,
    this.fontWeight, // Initialize fontWeight
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize ?? 20.0,
        color: color ?? Colors.black,
        fontWeight: fontWeight ?? FontWeight.bold, // Apply fontWeight
      ),
    );
  }
}
