import 'package:flutter/material.dart';
import 'package:shublie_customer/utils/colors.dart';
import 'package:shublie_customer/utils/images.dart'; // Import your color definitions

class XAppLogo extends StatelessWidget {
  const XAppLogo();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 55), // Default padding
      child: InkWell(
        onTap: () {
          Navigator.pushReplacementNamed(
              context, '/home'); // Navigate to home screen
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              appLogo,
              height: 120,
              width: 120,
            ),
            const SizedBox(height: 0), // Add spacing between image and text
            const Text(
              "Shublie",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24, // Optional: Adjust font size
                color: Colors.black, // Customize the text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
