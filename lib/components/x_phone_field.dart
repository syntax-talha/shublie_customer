import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shublie_customer/utils/colors.dart';

class XPhoneField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? labelColor;
  final String initialCountryCode;
  final Map<String, dynamic> validationRules; // New property for validation
  final String? serverError; // New property for server-side error

  const XPhoneField({
    required this.controller,
    required this.labelText,
    this.borderColor,
    this.backgroundColor,
    this.labelColor,
    this.initialCountryCode = 'US',
    this.validationRules = const {}, // Add validation rules parameter
    this.serverError, // Add the server error parameter
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntlPhoneField(
            controller: controller,
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: TextStyle(
                color: labelColor ?? Colors.black,
                fontSize: 16.0,
              ),
              filled: true,
              fillColor: backgroundColor ?? Colors.white,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: borderColor ?? Colors.grey[400]!,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: borderColor ?? primaryColor,
                  width: 2.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: borderColor ?? Colors.grey[400]!,
                  width: 1.0,
                ),
              ),
            ),
            initialCountryCode: initialCountryCode,
            onChanged: (phone) {
              print(phone.completeNumber);
            },
          ),
          // Validation message
          if (validationRules['isPhone'] == true &&
              !RegExp(r'^\+?[0-9]{10,15}$').hasMatch(controller.text))
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                'Enter a valid phone number',
                style: TextStyle(color: Colors.red, fontSize: 12.0),
              ),
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
}
