import 'package:flutter/material.dart';

class XIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;
  final double size;
  final EdgeInsets padding;
  final bool isLoading;

  const XIconButton({
    required this.icon,
    required this.onPressed,
    this.color,
    this.size = 24.0,
    this.padding = const EdgeInsets.all(8.0),
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: isLoading ? null : onPressed,
      icon: isLoading
          ? CircularProgressIndicator(color: color)
          : Icon(icon, color: color, size: size),
      padding: padding,
    );
  }
}
