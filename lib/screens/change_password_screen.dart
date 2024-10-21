import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shublie_customer/api/api_service.dart';
import 'package:shublie_customer/components/x_button.dart';
import 'package:shublie_customer/components/x_text_field.dart';
import 'package:shublie_customer/components/x_toastr.dart';
import 'package:shublie_customer/components/background_screen.dart'; // Import the BackgroundScreen
import 'package:shublie_customer/utils/images.dart'; // Import the background image

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  Map<String, String?> _fieldErrors = {};

  Future<void> _changePassword() async {
    setState(() => _isLoading = true);
    final currentPassword = _currentPasswordController.text;
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (_fieldErrors['new_password'] != null) {
      _fieldErrors['current_password'] = null;
    }

    if (newPassword != confirmPassword) {
      setState(() {
        _fieldErrors['new_password'] = 'Passwords do not match';
      });
      setState(() => _isLoading = false);
      return;
    } else {
      setState(() {
        _fieldErrors['new_password'] = null;
      });
    }

    try {
      final response = await api.changePassword(currentPassword, newPassword);
      print(response.statusCode);
      if (response.statusCode == 200) {
        XToastr.show(context, "Password changed successfully", "success");

        _clearForm();
      } else if (response.statusCode == 422) {
        final errorResponse = jsonDecode(response.body);
        handleFieldErrors(_fieldErrors, errorResponse);
      } else if (response.statusCode == 400) {
        setState(() {
          _fieldErrors['current_password'] = 'Current password is incorrect';
        });
      } else {
        setState(() {
          _fieldErrors['current_password'] = 'An unexpected error occurred';
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }

    setState(() => _isLoading = false);
  }

  void _clearForm() {
    _currentPasswordController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();
    _fieldErrors.clear();
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Change Password'),
        foregroundColor: Colors.white,
      ),
      body: BackgroundScreen(
        backgroundImage: bgImage_27, // Add background image
        overlayColor: Colors.white.withOpacity(0.6), // Add overlay
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        XTextField(
                          controller: _currentPasswordController,
                          labelText: 'Current Password',
                          isPassword: true,
                          icon: Icons.lock,
                          serverError: _fieldErrors['current_password'],
                        ),
                        XTextField(
                          controller: _newPasswordController,
                          labelText: 'New Password',
                          isPassword: true,
                          icon: Icons.lock,
                          serverError: _fieldErrors['new_password'],
                        ),
                        XTextField(
                          controller: _confirmPasswordController,
                          labelText: 'Confirm New Password',
                          isPassword: true,
                          icon: Icons.lock,
                          serverError: _fieldErrors['new_password'],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: XButton(
                  text: _isLoading ? 'Saving...' : 'Save',
                  textColor: Colors.white,
                  isLoading: _isLoading,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _changePassword();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleFieldErrors(
      Map<String, String?> fieldErrors, Map<String, dynamic> errorResponse) {
    setState(() {
      fieldErrors.clear();
      errorResponse['errors'].forEach((key, value) {
        fieldErrors[key] =
            value[0]; // Get the first error message for each field
      });
    });
  }
}
