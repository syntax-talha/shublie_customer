import 'package:flutter/material.dart';

class XDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  const XDialog({
    required this.title,
    required this.content,
    required this.actions,
  });

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String content,
    required List<Widget> actions,
  }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return XDialog(
          title: title,
          content: content,
          actions: actions,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: actions,
    );
  }
}
