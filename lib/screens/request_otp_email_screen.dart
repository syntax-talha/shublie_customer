import 'package:flutter/material.dart';
import 'package:shublie_customer/components/App/x_app_logo.dart';
import 'package:shublie_customer/components/background_screen.dart';
import 'package:shublie_customer/components/x_button.dart';
import 'package:shublie_customer/components/x_text_field.dart';
import 'package:shublie_customer/components/x_toastr.dart';
import 'package:shublie_customer/utils/colors.dart';
import 'package:shublie_customer/utils/images.dart';
import 'package:shublie_customer/components/x_text.dart';
import 'package:shublie_customer/components/x_heading.dart';
import 'package:shublie_customer/api/api_service.dart';
import 'package:shublie_customer/utils/validation.dart'; // Ensure the path is correct

class RequestOtpScreen extends StatefulWidget {
  @override
  _RequestOtpScreenState createState() => _RequestOtpScreenState();
}

class _RequestOtpScreenState extends State<RequestOtpScreen> {
    // final TextEditingController emailController =
      // TextEditingController(text: "mohsinali.msshahdin@gmail.com");
  final TextEditingController emailController =
      TextEditingController();
  bool isLoading = false; // Track loading state
  final ApiService apiService = ApiService(); // Initialize the API service

  Future<void> sendOtp() async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      
              XToastr.show(context, "Please enter your email address", "error");

      return;
    }

    setState(() {
      isLoading = true; // Show loading spinner
    });

    try {
      final response = await apiService.sendOtp(email);
      if (response.statusCode == 200) {
        // Navigate to OTP verification screen with email as argument
        Navigator.pushReplacementNamed(
          context,
          '/otp-verification-screen',
          arguments: {'email': email},
        );
      } else {
              XToastr.show(context, "Failed to send OTP. Please try again.", "error");

       
      }
    } catch (e) {
                 unexpectedError(context, e);

      
    } finally {
      setState(() {
        isLoading = false; // Hide loading spinner
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      backgroundImage: bgImage_8, // Use a suitable background image
      overlayColor: Colors.white.withOpacity(0.8),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Centered Logo
            Center(
              child: XAppLogo(), // Add the app logo similar to the Login screen
            ),

            // Title
            XHeading(
              text: 'Reset Password',
              fontSize: 28.0,
              color: primaryColor,
            ),
            const SizedBox(height: 16.0),

            // Instructions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: XText(
                text:
                    'Enter your email to receive an OTP code for resetting your password.',
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 24.0),

            // Email Field
            XTextField(
              controller: emailController,
              labelText: 'Enter your email',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 24.0),

            // Submit Button
            XButton(
              text: 'Send OTP',
              onPressed: sendOtp,
              isLoading: isLoading,
              textColor: Colors.white,
              color: primaryColor,
              buttonType: ButtonType.elevated,
            ),
          ],
        ),
      ),
    );
  }
}
