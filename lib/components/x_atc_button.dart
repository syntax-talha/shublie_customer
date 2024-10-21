import 'package:flutter/material.dart';

class CustomAddToCartButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomAddToCartButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 27, // Set your desired width
        height: 27, // Set your desired height
        decoration: BoxDecoration(
          color: Colors.black, // Change to your desired color
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), // Rounded top left corner
            bottomLeft: Radius.circular(0), // Rounded bottom left corner
            topRight: Radius.circular(0), // Square top right corner
            bottomRight: Radius.circular(10), // Square bottom right corner
          ),
        ),
        child: Center(
          child: Icon(
            Icons.add, // Replace with the icon you want
            color: Colors.white, // Change icon color as needed
          ),
        ),
      ),
    );
  }
}
