import 'package:flutter/material.dart';

class XProgressIndicator extends StatelessWidget {
  final double size;
  final Color color;

  const XProgressIndicator({
    this.size = 24.0,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: size / 10,
        valueColor: AlwaysStoppedAnimation(color),
      ),
    );
  }
}
