import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shublie_customer/api/api_service.dart';
import 'package:shublie_customer/api/auth_service.dart';
import 'package:shublie_customer/components/App/x_app_logo.dart';
import 'package:shublie_customer/components/background_screen.dart';
import 'package:shublie_customer/components/x_button.dart';
import 'package:shublie_customer/components/x_text_field.dart';
import 'package:shublie_customer/components/x_toastr.dart';
import 'package:shublie_customer/utils/colors.dart';
import 'package:shublie_customer/utils/images.dart';
import 'package:shublie_customer/components/x_link.dart';
import 'package:shublie_customer/components/x_text.dart';
import 'package:shublie_customer/components/x_heading.dart';
import 'package:shublie_customer/utils/validation.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController =
      TextEditingController(text: "mohsinali.msshahdin@gmail.com");
  final TextEditingController _passwordController =
      TextEditingController(text: "Testing@123");
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false; // Loading state
  Map<String, String?> _fieldErrors = {};

  Future<void> _login() async {
    setState(() => _isLoading = true);
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      final response = await api.login(email, password);

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        var role = responseBody["role"];
        if (role == "Customer") {
          auth.login(response.body);
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          XToastr.show(context, "Invalid Credentials", "error");
        }
      } else if (response.statusCode == 422) {
        final errorResponse = json.decode(response.body);
        handleFieldErrors(_fieldErrors, errorResponse);
        setState(() {});
      } else {
        unexpectedResponse(response, context);
      }
      setState(() => _isLoading = false);
    } catch (e) {
      unexpectedError(context, e);
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      backgroundImage: bgImage_12,
      overlayColor: Colors.white.withOpacity(0.1),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Add SizedBox to move the logo up
            const SizedBox(
                height: 0), // Adjust this value to move the logo up or down

            // App Logo
            XAppLogo(),
            // Login Label
            XHeading(
              text: 'Login',
              fontSize: 24.0,
              color: primaryColor,
            ),

            const SizedBox(height: 16.0),
            Container(
              child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        XTextField(
                          controller: _emailController,
                          labelText: 'Email',
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          serverError:
                              _fieldErrors['email'], // Show server error
                        ),

                        // Password Field
                        XTextField(
                          controller: _passwordController,
                          labelText: 'Password',
                          icon: Icons.lock_outlined,
                          isPassword: true,
                          serverError:
                              _fieldErrors['password'], // Show server error
                        ),

                        const SizedBox(height: 16.0),

                        // Forgot Password Link
                        Align(
                          alignment: Alignment.centerRight,
                          child: XLink(
                            text: 'Forgot Password?',
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/request-otp-email-screen');
                            },
                          ),
                        ),

                        const SizedBox(height: 16.0),

                        // Login Button
                        XButton(
                          text: _isLoading ? 'Logging in...' : 'Login',
                          onPressed: _login, // Disable button while loading
                          textColor: Colors.white,
                          color: primaryColor,
                          buttonType: ButtonType.elevated,
                        ),
                      ])),
            ),
            const SizedBox(height: 8.0),

            // Sign Up Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const XText(text: 'Don’t have an account? '),
                XLink(
                  text: 'Sign Up',
                  onTap: () {
                    Navigator.pushNamed(context, '/register');
                  },
                ),
              ],
            ),

            const SizedBox(height: 16.0),

            // Register as a Partner Link
            XLink(
              text: 'Register as a Partner',
              onTap: () {
                Navigator.pushNamed(context, '/register-partner');
              },
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
