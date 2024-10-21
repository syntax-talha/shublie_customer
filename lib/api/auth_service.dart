import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Singleton pattern
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;

  Map<String, dynamic>? _user; // Store all user data
  String? _token; // Store token
  String? _role; // Store role
  int? _id; // Store user ID

  static const String userKey = "user";
  static const String tokenKey = "token";
  static const String roleKey = "role";
  static const String idKey = "id";

  AuthService._internal(); // Private constructor for singleton

  // Store user data in local storage
  Future<void> login(String responseBody) async {
    try {
      var response = json.decode(responseBody);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(userKey,
          json.encode(response['user'])); // Ensure user data is stored as JSON
      await prefs.setString(tokenKey, response['token']);
      await prefs.setString(roleKey, response['role']);
      await prefs.setString(
          idKey, response['user']['id'].toString()); // Store ID as string

      // Store in memory
      _user = response['user'];
      _token = response['token'];
      _role = response['role'];
      _id = response['user']['id'];
    } catch (e) {
      debugPrint('Error storing auth data: $e');
    }
  }

  Future<void> updateUser(var user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(userKey, json.encode(user));
    _user = user;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(userKey);
    await prefs.remove(tokenKey);
    await prefs.remove(roleKey);
    await prefs.remove(idKey);

    // Clear in-memory data
    _user = null;
    _token = null;
    _role = null;
    _id = null;
  }

  Map<String, dynamic>? get user => _user; // Access user data
  String? get token => _token; // Access token
  String? get role => _role; // Access role
  int? get id => _id; // Access user ID
  // Getters to access user, token, role, and ID
  String? get name => _user != null &&
          _user!['first_name'] != null &&
          _user!['last_name'] != null
      ? '${_user!['first_name']} ${_user!['last_name']}'
      : null;
  String? get first_name => _user != null && _user!['first_name'] != null
      ? '${_user!['first_name']} '
      : null;
  String? get last_name => _user != null && _user!['last_name'] != null
      ? '${_user!['last_name']} '
      : null;
  String? get email => _user?['email']; // Using null-aware operator

  String? get phoneNumber =>
      _user?['phone_number']; // Using null-aware operator

  String? get profileImage =>
      _user?['profile_image']; // Using null-aware operator

  String? get address => _user?['address']; // Using null-aware operator
}

// Global instance of AuthService
AuthService get auth => AuthService();
