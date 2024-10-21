import 'package:flutter/material.dart';
import 'package:shublie_customer/utils/colors.dart';
class MainNavigationScreen extends StatelessWidget {
  final List<Map<String, String>> screens = [
    {'title': 'Splash Screen', 'route': '/splash'},
    {'title': 'Onboarding Screen', 'route': '/onboarding'},
    {'title': 'Login Screen', 'route': '/login'},
    {'title': 'Register Screen', 'route': '/register'},
    {'title': 'Home Screen', 'route': '/home'},
    {'title': 'Search Screen', 'route': '/search'},
    // {'title': 'Service Selection Screen', 'route': '/service-selection'},
    // {'title': 'Vendor Item Detail Screen', 'route': '/vendor-item-detail'},
    {'title': 'Order Tracking Screen', 'route': '/order-tracking'},
    {'title': 'Review Rating Screen', 'route': '/review-rating'},
    {'title': 'Profile Screen', 'route': '/profile'},
    {'title': 'Notifications Screen', 'route': '/notifications'},
    {'title': 'Settings Screen', 'route': '/settings'},
    {'title': 'Reset Password Screen', 'route': '/reset-password-screen'},
    {'title': 'OTP Verification Screen', 'route': '/otp-verification-screen'},
    {'title': 'Request OTP Email Screen', 'route': '/request-otp-email-screen'},
    // {'title': 'Request OTP Contact Number Screen', 'route': '/request-otp-contact-number-screen'},
    {'title': 'Order Details Screen', 'route': '/order-details-screen'},
    {'title': 'Support FAQ Screen', 'route': '/support-faq-screen'},
    {'title': 'Service Details Screen', 'route': '/service-details-screen'},
    {'title': 'Booking Screen', 'route': '/booking-screen'},
    {'title': 'Booking Home Screen', 'route': '/booking-home-screen'},
    {'title': 'Payment Screen', 'route': '/payment-screen'},
    {'title': 'Order Summary Screen', 'route': '/order-summary-screen'},
    {'title': 'Vendor List Screen', 'route': '/vendor-list-screen'},
    // {'title': 'OTP Register Verification Screen', 'route': '/otp-register-verification-screen'},
    {'title': 'Payment Settings Screen', 'route': '/payment-settings-screen'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Navigation Screen'),
        backgroundColor: primaryColor, // Primary color
      ),
      body: ListView.builder(
        itemCount: screens.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(screens[index]['title']!),
            onTap: () {
              Navigator.pushNamed(context, screens[index]['route']!);
            },
          );
        },
      ),
    );
  }
}
