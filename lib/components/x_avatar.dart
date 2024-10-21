import 'package:flutter/material.dart';

class XAvatar extends StatelessWidget {
  final String imageUrl;
  final double radius;
  final Color backgroundColor;

  const XAvatar({
    required this.imageUrl,
    this.radius = 24.0,
    this.backgroundColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage(imageUrl),
      radius: radius,
      backgroundColor: backgroundColor,
    );
  }
}
