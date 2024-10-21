import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shublie_customer/api/api_service.dart';
import 'package:shublie_customer/api/auth_service.dart';
import 'package:shublie_customer/components/background_screen.dart';
import 'package:shublie_customer/components/x_button.dart';
import 'package:shublie_customer/components/x_phone_field.dart';
import 'package:shublie_customer/components/x_text_field.dart';
import 'package:shublie_customer/screens/settings_screen.dart';
import 'package:shublie_customer/utils/colors.dart';
import 'package:shublie_customer/utils/configs.dart';
import 'package:shublie_customer/utils/images.dart';
import 'package:shublie_customer/utils/validation.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController first_name =
      TextEditingController(text: auth.first_name);
  final TextEditingController last_name =
      TextEditingController(text: auth.last_name);
  final TextEditingController phone_number =
      TextEditingController(text: auth.phoneNumber);
  final TextEditingController address =
      TextEditingController(text: auth.address);

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false; // Loading state
  Map<String, String?> _fieldErrors = {};

  File? _imageFile; // To store selected image

  // Image picker instance
  final ImagePicker _picker = ImagePicker();
  final String id = auth.id.toString();

  // Function to pick an image
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      _updatePartnerImage();
    }
  }

  // Function to update partner image
  Future<void> _updatePartnerImage() async {
    if (_imageFile != null) {
      setState(() => _isLoading = true);
      try {
        final response = await api.updatePartnerImage(id, _imageFile!);

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          auth.updateUser(data['user']); // Update the profile picture in auth
          setState(() {});
        } else {
          final errorData = json.decode(response.body);
          String errorMessage =
              errorData['message'] ?? 'Unexpected error occurred.';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
      setState(() => _isLoading = false);
    }
  }

  // Function to update user details
  Future<void> _updateUser() async {
    setState(() => _isLoading = true);
    final customerData = {
      'first_name': first_name.text,
      'last_name': last_name.text,
      'phone_number': phone_number.text,
      'address': address.text,
    };

    try {
      final response = await api.updateProfile(customerData);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        auth.updateUser(data['user']);
        Navigator.pop(context);
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
    final String profileImageUrl =
        "${baseUrl}/${auth.profileImage}"; // Full image URL
    print(profileImageUrl);
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: BackgroundScreen(
        backgroundImage: bgImage_26,
        overlayColor: Colors.white.withOpacity(0.6),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Profile Image (Tap to update)
                Center(
                  child: GestureDetector(
                    onTap: _pickImage, // Pick image on tap
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!) // Show selected image
                          : NetworkImage(profileImageUrl)
                              as ImageProvider, // Show existing image from server
                      backgroundColor: primaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),

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

                SizedBox(
                  width: double.infinity,
                  child: XButton(
                    text: _isLoading ? 'Loading...' : 'Save',
                    onPressed: _updateUser,
                    isLoading: _isLoading,
                    textColor: Colors.white,
                    color: primaryColor,
                    buttonType: ButtonType.elevated,
                  ),
                ),

                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
