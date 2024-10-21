import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shublie_customer/api/api_service.dart';
import 'package:shublie_customer/components/background_screen.dart';
import 'package:shublie_customer/components/x_button.dart';
import 'package:shublie_customer/components/x_phone_field.dart';
import 'package:shublie_customer/components/x_text_field.dart';
import 'package:shublie_customer/utils/colors.dart';
import 'package:shublie_customer/utils/images.dart';
import 'package:shublie_customer/components/x_link.dart';
import 'package:shublie_customer/components/x_checkbox.dart';
import 'package:shublie_customer/utils/validation.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //   final TextEditingController first_name =
  //     TextEditingController(text: "Mohsin");
  // final TextEditingController last_name = TextEditingController(text: "Ali");
  // final TextEditingController email =
  //     TextEditingController(text: "mohsinali.msshahdin@gmail.com");
  // final TextEditingController phone_number =
  //     TextEditingController(text: "1111111111");
  // final TextEditingController address = TextEditingController(text: "lahore");
  // final TextEditingController password =
  //     TextEditingController(text: "Testing@123");
  final TextEditingController first_name = TextEditingController();
  final TextEditingController last_name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone_number = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool _termsAccepted = false;

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false; // Loading state
  Map<String, String?> _fieldErrors = {};
  final ApiService apiService = ApiService();

  Future<void> _registerUser() async {
    setState(() => _isLoading = true);
    final customerData = {
      'first_name': first_name.text,
      'last_name': last_name.text,
      'email': email.text,
      'phone_number': phone_number.text,
      'address': address.text,
      'password': password.text,
      'terms_accepted': _termsAccepted,
    };

    try {
      final response = await apiService.registerCustomer(customerData);

      if (response.statusCode == 200) {
        Navigator.pushReplacementNamed(
          context,
          '/otp-register-verification-screen',
          arguments: {'email': email.text}, // Pass email as argument
        );
      } else if (response.statusCode == 422) {
        final errorResponse = json.decode(response.body);
        handleFieldErrors(_fieldErrors, errorResponse);
        setState(() {});
      } else {
        unexpectedResponse(response, context);
      }
    } catch (e) {
      unexpectedError(context, e);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
        backgroundImage: bgImage_26,
        overlayColor: Colors.white.withOpacity(0.6),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 16.0),
                // First Name Field
                XTextField(
                  controller: first_name,
                  labelText: 'First Name',
                  icon: Icons.person,
                  serverError: _fieldErrors['first_name'], // Show server error
                ),
                SizedBox(height: 16.0),
                // Last Name Field
                XTextField(
                  controller: last_name,
                  labelText: 'Last Name',
                  icon: Icons.person_outline,
                  serverError: _fieldErrors['last_name'], // Show server error
                ),
                SizedBox(height: 16.0),

                // Email Address Field
                XTextField(
                  controller: email,
                  labelText: 'Email Address',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  serverError: _fieldErrors['email'], // Show server error
                ),
                SizedBox(height: 16.0),

                // Contact Field
                XPhoneField(
                  controller: phone_number,
                  labelText: 'Contact',
                  initialCountryCode: 'US',
                  borderColor: Colors.grey,
                  backgroundColor: Colors.white,
                  serverError:
                      _fieldErrors['phone_number'], // Show server error
                ),
                const SizedBox(height: 10.0),

                // Address Field
                XTextField(
                  controller: address,
                  labelText: 'Address',
                  icon: Icons.location_on,
                  serverError: _fieldErrors['address'], // Show server error
                ),
                SizedBox(height: 16.0),

                // Password Field
                XTextField(
                  controller: password,
                  labelText: 'Password',
                  icon: Icons.lock,
                  isPassword: true,
                  serverError: _fieldErrors['password'], // Show server error
                ),
                SizedBox(height: 16.0),

                // Terms and Conditions Checkbox
                Row(
                  children: <Widget>[
                    XCheckbox(
                      value: _termsAccepted,
                      onChanged: (bool? value) {
                        setState(() {
                          _termsAccepted = value!;
                        });
                      },
                      checkColor: Colors.white,
                      activeColor: primaryColor,
                      checkBoxBorderColor: Colors.grey,
                    ),
                    const Text('I accept the '),
                    XLink(
                      text: 'Terms and Conditions',
                      onTap: () {
                        // Handle terms and conditions click
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16.0),

                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  child: XButton(
                    text: _isLoading ? 'Loading...' : 'Sign Up',
                    onPressed: _registerUser,
                    isLoading: _isLoading,
                    textColor: Colors.white,
                    color: primaryColor,
                    buttonType: ButtonType.elevated,
                  ),
                ),

                const SizedBox(height: 16.0),

                // Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? '),
                    XLink(
                      text: 'Login',
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
