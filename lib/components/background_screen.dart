import 'package:flutter/material.dart';

class BackgroundScreen extends StatelessWidget {
  final String backgroundImage;
  final Widget child;
  final Color? overlayColor;

  const BackgroundScreen({
    required this.backgroundImage,
    required this.child,
    this.overlayColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            backgroundImage,
            fit: BoxFit.cover,
          ),
          if (overlayColor != null)
            Container(
              color: overlayColor, // Semi-transparent overlay
            ),
          child,
        ],
      ),
    );
  }
}
