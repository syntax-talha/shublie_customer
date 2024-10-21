import 'package:flutter/material.dart';
import 'package:shublie_customer/screens/x_list_tile.dart'; // Ensure the correct path is used
import 'package:shublie_customer/utils/colors.dart'; // Import your primary color
import 'package:shublie_customer/screens/reset_password_screen.dart'; // Import your ResetPasswordScreen

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Example notifications
    final notifications = [
      {
        'title': 'GPS Update',
        'message': 'Your location has been updated.',
        'icon': Icons.location_on,
        'time': '2 min ago',
      },
      {
        'title': 'Payment Held',
        'message': 'Your payment is on hold. Please verify your details.',
        'icon': Icons.payment,
        'time': '10 min ago',
      },
      {
        'title': 'Password Change',
        'message': 'Your password has been successfully changed.',
        'icon': Icons.lock,
        'time': '1 hour ago',
      },
      {
        'title': 'Email Confirmation',
        'message': 'Please confirm your email address to complete registration.',
        'icon': Icons.email,
        'time': '1 day ago',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          final subtitle =
              '${notification['message'] as String} (${notification['time'] as String})';

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: XListTile(
                title: notification['title'] as String,
                subtitle: subtitle,
                leadingIcon: notification['icon'] as IconData,
                trailingIcon: Icons.arrow_forward_ios,
                onTap: () {
                  if (notification['title'] == 'Password Change') {
                    // Navigate to ResetPasswordScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResetPasswordScreen(),
                      ),
                    );
                  } else {
                    print('Tapped on: ${notification['title']}');
                  }
                },
                selected: false,
              ),
            ),
          );
        },
      ),
    );
  }
}
