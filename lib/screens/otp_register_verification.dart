import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shublie_customer/api/api_service.dart';
import 'package:shublie_customer/components/App/x_app_logo.dart';
import 'package:shublie_customer/components/x_button.dart'; // Ensure correct path
import 'package:shublie_customer/components/x_toastr.dart';
import 'package:shublie_customer/utils/colors.dart'; // Ensure correct path
import 'package:shublie_customer/components/background_screen.dart'; // Ensure correct path
import 'package:shublie_customer/utils/images.dart'; // Ensure correct path
import 'package:shublie_customer/components/x_link.dart'; // Import the XLink component

class OtpRegisterVerificationScreen extends StatefulWidget {
  @override
  _OtpRegisterVerificationScreenState createState() =>
      _OtpRegisterVerificationScreenState();
}

class _OtpRegisterVerificationScreenState
    extends State<OtpRegisterVerificationScreen> {
  final List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());
  bool isResendEnabled = false;
  bool isResending = false; // Track if we are resending
  int countdown = 30;
  Timer? countdownTimer;
  String? email; // Variable to hold the email
  final ApiService apiService = ApiService(); // Initialize ApiService
  bool _isLoading = false; // Loading state

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Receive the email from the arguments
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    email = args['email']; // Extract the email
  }

  void startCountdown() {
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        setState(() {
          countdown--;
          isResendEnabled = false;
          isResending = false; // Reset resending status
        });
      } else {
        timer.cancel();
        setState(() {
          isResendEnabled = true;
        });
      }
    });
  }

  Future<void> resendOtp() async {
    setState(() {
      isResending = true; // Set resending status
      isResendEnabled = false; // Disable resend button
    });

    // Call the API to resend the OTP
    final response = await apiService.sendOtp(email!);
    if (response.statusCode == 200) {
      setState(() {
        countdown = 30; // Reset countdown
        startCountdown(); // Start countdown
        isResending = false; // Reset resending status
      });
      // Handle successful resend (e.g., show a message)
      
      XToastr.show(context, 'OTP has been resent to $email', "success");

    } else {
      // Handle error
      setState(() {
        isResending = false; // Reset resending status
        isResendEnabled = true; // Re-enable resend button
      });
      XToastr.show(context, 'Failed to resend OTP. Please try again.', "error");

   
    }
  }

  Future<void> verifyOtp() async {
    setState(() => _isLoading = true);

    String otp = otpControllers.map((controller) => controller.text).join('');
    // Call the API to verify the OTP
    final response = await apiService.verifyOtp(email!, otp);
    if (response.statusCode == 200) {
      // Handle successful verification (e.g., navigate to home)
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      XToastr.show(context, 'Invalid or expired OTP. Please try again.', "error");

      
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    otpControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _onOtpChanged(String value, int index) {
    
    if (value.length == 1) {
      // Move to next field if single character entered
      if (index < otpControllers.length - 1) {
        FocusScope.of(context).nextFocus();
      }
    } else if (value.length > 1) {
      // Handle pasting multiple characters
      for (int i = 0;
          i < value.length && i + index < otpControllers.length;
          i++) {
        otpControllers[index + i].text = value[i];
      }
      // Move to the next field after the last character
      if (index + value.length < otpControllers.length) {
        FocusScope.of(context).nextFocus();
      }
    }

    if (value.isEmpty && index > 0) {
      FocusScope.of(context).previousFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      backgroundImage: bgImage_8, // Use a suitable background image
      overlayColor: Colors.white.withOpacity(0.8),
      child: Column(
        children: [
          // Centered Logo
          Center(
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: XAppLogo(), // Add the app logo
            ),
          ),

          // Title
          Text(
            'OTP Verification',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: primaryColor, // Use the primary color
            ),
          ),
          const SizedBox(height: 16.0),

          // Instructions with email
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'A One Time Password has been sent to $email.', // Display the email
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0, color: Colors.black54),
            ),
          ),
          const SizedBox(height: 24.0),

          // OTP Input Fields
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(6, (index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                width: 40,
                child: TextField(
                  controller: otpControllers[index],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  decoration: InputDecoration(
                    counterText: '',
                    filled: true,
                    fillColor: Colors.white, // Light background color
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: primaryColor), // Border color
                      borderRadius:
                          BorderRadius.circular(8.0), // Rounded corners
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: primaryColor), // Border color when focused
                      borderRadius:
                          BorderRadius.circular(8.0), // Rounded corners
                    ),
                  ),
                  onChanged: (value) => _onOtpChanged(value, index),
                ),
              );
            }),
          ),
          SizedBox(height: 20),

          // Resend OTP Section
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Did not receive OTP? ',
                style: TextStyle(fontSize: 16),
              ),
              if (isResending)
                Text(
                  'Resending...',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                )
              else if (!isResendEnabled)
                Text(
                  'Resend in $countdown seconds',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                )
              else
                XLink(
                  text: 'Resend OTP',
                  onTap: resendOtp,
                ),
            ],
          ),
          SizedBox(height: 20),

          // Center the Verify Button
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: XButton(
              text: 'Verify',
              onPressed: verifyOtp,
              isLoading: _isLoading,
              buttonType: ButtonType.elevated,
              color: primaryColor, // Use the primary color
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
