// x_expansion_tile.dart
import 'package:flutter/material.dart';

class XExpansionTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Widget> children;

  const XExpansionTile({
    required this.title,
    this.subtitle,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      children: children,
    );
  }
}
