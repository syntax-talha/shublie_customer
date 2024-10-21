import 'package:flutter/material.dart';
import 'package:shublie_customer/utils/colors.dart';

enum TextFieldType {
  underline,
  outline,
}

class XTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData? icon;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? labelColor;
  final Color? iconColor;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextFieldType type;
  final bool isLabelAbove;
  final bool isIconInside;
  final Map<String, dynamic> validationRules;
  final String? serverError; // New property for server-side error

  const XTextField({
    required this.controller,
    required this.labelText,
    this.icon,
    this.borderColor,
    this.backgroundColor,
    this.labelColor,
    this.iconColor = primaryColor,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.type = TextFieldType.outline,
    this.isLabelAbove = false,
    this.isIconInside = false,
    this.validationRules = const {},
    this.serverError, // Add the server error parameter
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isLabelAbove)
            Text(
              labelText,
              style: TextStyle(
                color: labelColor ?? Colors.black,
                fontSize: 16.0,
              ),
            ),
          if (isLabelAbove) const SizedBox(height: 8.0),
          TextFormField(
            controller: controller,
            obscureText: isPassword,
            keyboardType: keyboardType,
            decoration: _getInputDecoration(),
            validator: (value) => _dynamicValidator(value),
          ),
          if (serverError != null) // Display server-side error if present
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                serverError!,
                style: TextStyle(color: Colors.red, fontSize: 12.0),
              ),
            ),
        ],
      ),
    );
  }

  String? _dynamicValidator(String? value) {
    if (validationRules['required'] == true &&
        (value == null || value.isEmpty)) {
      return 'This field is required';
    }

    if (validationRules['isEmail'] == true &&
        !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value ?? '')) {
      return 'Enter a valid email';
    }

    if (validationRules['isNumber'] == true &&
        double.tryParse(value ?? '') == null) {
      return 'Enter a valid number';
    }

    return null; // No errors
  }

  InputDecoration _getInputDecoration() {
    return InputDecoration(
      filled: type == TextFieldType.outline,
      fillColor: backgroundColor ?? Colors.white,
      border: _getBorder(),
      focusedBorder: _getBorder(color: borderColor ?? primaryColor),
      enabledBorder: _getBorder(color: borderColor ?? Colors.grey),
      suffixIcon: !isIconInside && icon != null
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Icon(icon, color: iconColor ?? Colors.grey),
            )
          : null,
      prefixIcon: isIconInside && icon != null
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Icon(icon, color: iconColor ?? Colors.grey),
            )
          : null,
      labelText: !isLabelAbove ? labelText : null,
      labelStyle: TextStyle(color: labelColor ?? Colors.black),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
    );
  }

  InputBorder _getBorder({Color? color}) {
    return type == TextFieldType.outline
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: color ?? Colors.grey, width: 1.0),
          )
        : UnderlineInputBorder(
            borderSide: BorderSide(color: color ?? Colors.grey, width: 1.0),
          );
  }
}
