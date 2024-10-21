// request_otp_contact_number_screen.dart

import 'package:flutter/material.dart';
import 'package:shublie_customer/components/x_text_field.dart'; // Update with the correct path to your XTextField component
import 'package:shublie_customer/components/x_button.dart'; // Update with the correct path to your XButton component

class RequestOtpContactNumberScreen extends StatelessWidget {
  final TextEditingController contactNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double topSpacing = screenHeight * 0.20; // 20% of screen height

    return Scaffold(
      body: Column(
        children: [
          // Custom AppBar-like Container
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16.0),
            decoration: BoxDecoration(
              color: Colors.blue, // Background color for the entire bar
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0)),
            ),
            child: Center(
              child: Text(
                'Get OTP via Contact Number',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
          // Spacer to leave 20% of screen height from the top
          SizedBox(height: topSpacing),
          // Main content
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Confirm Your Contact Number:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),

                  // Contact Number Input Field
                  XTextField(
                    controller: contactNumberController,
                    labelText: 'Enter your contact number',
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone, // For phone number input
                  ),
                  SizedBox(height: 20),

                  // Center the Submit Button
                  Center(
                    child: XButton(
                      text: 'Submit',
                      onPressed: () {
                        // Handle submit action
                      },
                      buttonType: ButtonType.elevated,
                      color: Colors.blue, // Customize button color here
                      textColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Get OTP through Email Text with Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Get OTP through Email ',
                        style: TextStyle(fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                         Navigator.pushNamed(context, '/request-otp-email-screen'); // Handle get OTP through email action
                        },
                        child: Text(
                          'here',
                          style: TextStyle(fontSize: 16, color: Colors.blue, decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
