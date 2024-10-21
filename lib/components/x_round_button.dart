import 'package:flutter/material.dart';
import 'package:shublie_customer/utils/colors.dart';

enum ButtonType { elevated, filled, filledTonal, outlined, text }

class XRoundButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final String? imagePath;
  final VoidCallback onPressed;
  final ButtonType buttonType;
  final Color? color;
  final Color? textColor;
  final bool isLoading;
  final double borderRadius;
  final double padding;

  const XRoundButton({
    required this.onPressed,
    this.text,
    this.icon,
    this.imagePath,
    this.buttonType = ButtonType.elevated,
    this.color,
    this.textColor,
    this.isLoading = false,
    this.borderRadius = 8.0,
    this.padding = 16.0,
  }) : assert(
          (text != null || imagePath != null),
          'Text or imagePath must be provided',
        );

  @override
  Widget build(BuildContext context) {
    Widget buttonChild = isLoading
        ? CircularProgressIndicator(color: textColor)
        : (icon != null
            ? Icon(icon, color: textColor)
            : (imagePath != null
                ? Image.asset(imagePath!, width: 24, height: 24)
                : Text(
                    text!,
                    style: TextStyle(color: textColor),
                  )));

    return Column(
      children: [
        _buildButton(buttonChild),
        if (text != null && imagePath != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              text!,
              style: TextStyle(color: textColor),
            ),
          ),
      ],
    );
  }

  Widget _buildButton(Widget buttonChild) {
    switch (buttonType) {
      case ButtonType.elevated:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? primaryColor, // Default color if not provided
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            padding: EdgeInsets.all(padding),
          ),
          child: buttonChild,
        );
      case ButtonType.filled:
        return FilledButton(
          onPressed: isLoading ? null : onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: color ?? primaryColor, // Default color if not provided
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            padding: EdgeInsets.all(padding),
          ),
          child: buttonChild,
        );
      case ButtonType.filledTonal:
        return FilledButton.tonal(
          onPressed: isLoading ? null : onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: color ?? primaryColor, // Default color if not provided
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            padding: EdgeInsets.all(padding),
          ),
          child: buttonChild,
        );
      case ButtonType.outlined:
        return OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: textColor ?? primaryColor, // Text color (foreground color) for outlined button
            side: BorderSide(color: color ?? primaryColor), // Border color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            padding: EdgeInsets.all(padding),
          ),
          child: buttonChild,
        );
      case ButtonType.text:
        return TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: textColor ?? primaryColor, // Text color (foreground color) for text button
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            padding: EdgeInsets.all(padding),
          ),
          child: buttonChild,
        );
      default:
        return Container();
    }
  }
}
