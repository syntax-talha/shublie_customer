import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shublie_customer/api/api_service.dart';
import 'package:shublie_customer/components/App/x_app_logo.dart';
import 'package:shublie_customer/components/x_text_field.dart';
import 'package:shublie_customer/components/x_button.dart';
import 'package:shublie_customer/components/background_screen.dart';
import 'package:shublie_customer/components/x_toastr.dart';
import 'package:shublie_customer/utils/colors.dart';
import 'package:shublie_customer/utils/images.dart';
import 'package:shublie_customer/components/x_text.dart';
import 'package:shublie_customer/components/x_heading.dart';
import 'package:shublie_customer/utils/validation.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final ApiService apiService =
      ApiService(); // Create an instance of ApiService
  Map<String, String?> _fieldErrors = {};
  bool _isLoading = false; // Loading state

  // Function to handle reset password
  void resetPassword(String token) async {
    setState(() => _isLoading = true);

    final String newPassword = newPasswordController.text;
    final String confirmPassword = confirmPasswordController.text;

    final passwordData = {
      'password': newPassword,
      'password_confirmation': confirmPassword,
    };

    // Call the API to reset the password
    final response = await apiService.resetPassword(passwordData, token);
    var st = response.statusCode;

    if (response.statusCode == 200) {
              XToastr.show(context, "Password Changed Succuessfuly!", "success");
      
     
      Future.delayed(const Duration(seconds: 1), () {
        // Handle success, navigate to the home screen or show a success message
        Navigator.pushReplacementNamed(context, '/home');
      });
    } else if (response.statusCode == 422) {
      final errorResponse = json.decode(response.body);
      handleFieldErrors(_fieldErrors, errorResponse);
    } else {
      unexpectedResponse(response, context);
    }
    setState(() {
      _isLoading = false;
      // _fieldErrors = {};
    });
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the token from the arguments
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String token = args['token']; // Get the token from the arguments

    return BackgroundScreen(
      backgroundImage: bgImage_8,
      overlayColor: Colors.white.withOpacity(0.8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: XAppLogo(),
              ),
            ),
            const SizedBox(height: 32.0),
            XHeading(
              text: 'Reset Password',
              fontSize: 28.0,
              color: primaryColor,
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: XText(
                text: 'Enter your new password below.',
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  XTextField(
                    controller: newPasswordController,
                    labelText: 'New Password',
                    icon: Icons.lock,
                    isPassword: true,
                    serverError: _fieldErrors['password'], // Show server error
                  ),
                  const SizedBox(height: 16),
                  XTextField(
                    controller: confirmPasswordController,
                    labelText: 'Confirm New Password',
                    icon: Icons.lock,
                    isPassword: true,
                    serverError: _fieldErrors[
                        'password_confirmation'], // Show server error
                  ),
                  const SizedBox(height: 24),
                  XButton(
                    text: 'Save',
                    isLoading: _isLoading,
                    onPressed: () {
                      resetPassword(
                          token); // Call the reset password function with the token
                    },
                    buttonType: ButtonType.elevated,
                    color: primaryColor,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
