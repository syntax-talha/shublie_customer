import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shublie_customer/api/auth_service.dart';
import 'package:shublie_customer/utils/configs.dart';

class ApiService {
  // Login API
  Future<http.Response> login(String email, String password) async {
    final url = Uri.parse('$apiUrl/auth/login');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    return response;
  }

// Fetch all Partner
  Future<http.Response> fetchPartner() async {
    final url = Uri.parse('$apiUrl/partner/read');
    final response = await http.post(url);
    return response;
  }

  Future<http.Response> updatePartnerImage(
      String id, File profile_image) async {
    final url = Uri.parse('$apiUrl/partner/picture');

    // Create a multipart request
    var request = http.MultipartRequest('POST', url);
    request.fields['id'] = id; // Include the ID field
    request.files.add(await http.MultipartFile.fromPath(
      'profile_image', // The name of the file field in your API
      profile_image.path,
    ));

    // Send the request
    var response = await request.send();

    // Return the response
    return await http.Response.fromStream(response);
  }

  // Register Customer API
  Future<http.Response> registerCustomer(
      Map<String, dynamic> customerData) async {
    final url = Uri.parse('$apiUrl/auth/register/customer');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(customerData),
    );
    return response;
  }

  // Register Partner API
  Future<http.Response> registerPartner(
      Map<String, dynamic> partnerData) async {
    final url = Uri.parse('$apiUrl/auth/register/partner');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(partnerData),
    );

    return response;
  }

  // Send OTP API
  Future<http.Response> sendOtp(String email) async {
    final url = Uri.parse('$apiUrl/auth/send-otp');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'email': email}),
    );

    return response;
  }

  // Verify OTP API
  Future<http.Response> verifyOtp(String email, String otp) async {
    final url = Uri.parse('$apiUrl/auth/verify-otp');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'email': email, 'otp': otp}),
    );

    return response;
  }

  Future<http.Response> resetPassword(
      Map<String, dynamic> data, String _token) async {
    final url = Uri.parse('$apiUrl/auth/reset-password');
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization":
            "Bearer $_token", // Add the token to the Authorization header
      },
      body: jsonEncode(data),
    );

    return response;
  }

// Update Profile API
  Future<http.Response> updateProfile(Map<String, dynamic> profileData) async {
    final url = Uri.parse('$apiUrl/auth/update-profile');
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization":
            "Bearer ${auth.token}", // Add the token to the Authorization header
      },
      body: jsonEncode(profileData),
    );
    return response;
  }

  // Change Password API
  Future<http.Response> changePassword(
      String currentPassword, String newPassword) async {
    final url = Uri.parse('$apiUrl/auth/change-password');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'current_password': currentPassword,
        'new_password': newPassword,
        'new_password_confirmation': newPassword,
      }),
    );

    return response;
  }

  // Fetch all categories
  Future<http.Response> fetchCategories() async {
    final url = Uri.parse('$apiUrl/category/read');
    final response = await http.post(url);
    return response;
  }

  // Fetch category by ID
  Future<http.Response> fetchCategoryById(int id) async {
    final url = Uri.parse('$apiUrl/category/read/$id');
    final response = await http.post(url);

    return response;
  }

  // Store new category
  Future<http.Response> storeCategory(Map<String, dynamic> categoryData) async {
    final url = Uri.parse('$apiUrl/category/store');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(categoryData),
    );

    return response;
  }

  // Delete category by ID
  Future<http.Response> deleteCategory(int id) async {
    final url = Uri.parse('$apiUrl/category/delete/$id');
    final response = await http.delete(url);
    return response;
  }

  // Fetch all services
  Future<http.Response> fetchServices() async {
    final url = Uri.parse('$apiUrl/service/read');
    final response = await http.post(url);

    return response;
  }

  // Fetch service by ID
  Future<http.Response> fetchServiceById(String id) async {
    final url = Uri.parse('$apiUrl/service/read/$id');
    final response = await http.post(url);

    return response;
  }

  // Store new service
  Future<http.Response> storeService(Map<String, dynamic> serviceData) async {
    final url = Uri.parse('$apiUrl/service/store');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(serviceData),
    );

    return response;
  }

  // Store service images (Multipart/form-data)
  void storeServiceImages(int serviceId, List<String> imagePaths) async {
    final url = Uri.parse('$apiUrl/service/images/store');
    var request = http.MultipartRequest('POST', url);

    request.fields['service_id'] = serviceId.toString();
    for (var imagePath in imagePaths) {
      request.files
          .add(await http.MultipartFile.fromPath('images[]', imagePath));
    }

    var response = await request.send();
    // return response;
  }

  // Delete service by ID
  Future<http.Response> deleteService(int id) async {
    final url = Uri.parse('$apiUrl/service/delete/$id');
    final response = await http.delete(url);
    return response;
  }

  // Delete service image by URL
  Future<http.Response> deleteServiceImage(
      int serviceId, String imageUrl) async {
    final url = Uri.parse('$apiUrl/service/images/delete');
    final response = await http.delete(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'service_id': serviceId,
        'image_url': imageUrl,
      }),
    );

    return response;
  }
// Fetch all Bookings
  Future<http.Response> fetchBookings() async {
    final url = Uri.parse('$apiUrl/booking/read');
    final response = await http.post(url);
    return response;
  }

  Future<http.Response> getChats() async {
    final url = Uri.parse('$apiUrl/chats/${auth.id}');
    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    return response;
  }

  Future<http.Response> getMessages(String receiverId) async {
    final url = Uri.parse('$apiUrl/messages/${auth.id}/$receiverId');
    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    return response;
  }

  Future<http.Response> sendMessage(String receiverId, String content) async {
    final url = Uri.parse('$apiUrl/send/message');
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${auth.token}",
      },
      body: jsonEncode({"content": content, "receiver_id": receiverId}),
    );

    return response;
  }
}

ApiService get api => ApiService();
