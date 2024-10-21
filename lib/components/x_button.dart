import 'package:flutter/material.dart';
import 'package:shublie_customer/utils/colors.dart';

enum ButtonType { elevated, filled, filledTonal, outlined, text }

class XButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final VoidCallback onPressed;
  final ButtonType buttonType;
  final Color? color;
  final Color? textColor;
  final bool isLoading;
  final double borderRadius;
  final double padding;
  final double loadingIndicatorSize; // Size of the loading indicator

  const XButton({
    required this.onPressed,
    this.text,
    this.icon,
    this.buttonType = ButtonType.elevated,
    this.color,
    this.textColor,
    this.isLoading = false,
    this.borderRadius = 8.0,
    this.padding = 20,
    this.loadingIndicatorSize = 20.0, // Default loading indicator size
  }) : assert(
          (text != null || icon != null),
          'Text or icon must be provided for the button',
        );

  @override
  Widget build(BuildContext context) {
    Widget buttonChild = isLoading
        ? SizedBox(
            width: loadingIndicatorSize,
            height: loadingIndicatorSize,
            child: CircularProgressIndicator(color: textColor),
          )
        : (icon != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: textColor),
                  if (text != null) SizedBox(width: 8),
                  if (text != null)
                    Text(
                      text!,
                      style: TextStyle(color: textColor),
                    ),
                ],
              )
            : Text(
                text!,
                style: TextStyle(color: textColor),
              ));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: _buildButton(buttonChild),
      ),
    );
  }

  Widget _buildButton(Widget buttonChild) {
    switch (buttonType) {
      case ButtonType.elevated:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: color ?? textColor,
            backgroundColor: color ?? primaryColor,
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
            backgroundColor: color ?? primaryColor,
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
            backgroundColor: color ?? primaryColor,
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
            foregroundColor: textColor ?? primaryColor,
            side: BorderSide(color: color ?? primaryColor),
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
            foregroundColor: textColor ?? primaryColor,
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
