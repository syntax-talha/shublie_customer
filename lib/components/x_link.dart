import 'package:flutter/material.dart';
import 'package:shublie_customer/utils/colors.dart';

class XLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final TextAlign? textAlign;

  const XLink({
    required this.text,
    required this.onTap,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        textAlign: textAlign,
        style: const TextStyle(
          color: primaryColor, // You can replace this with primaryColor
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic
          // decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
