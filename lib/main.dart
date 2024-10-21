import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shublie_customer/screens/otp_register_verification.dart';
import 'package:shublie_customer/screens/request_otp_email_screen.dart';
import 'package:shublie_customer/screens/service_details_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
// import 'screens/service_selection_screen.dart';
import 'screens/vendor_item_detail_screen.dart';
import 'screens/order_tracking_screen.dart';
import 'screens/review_rating_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/reset_password_screen.dart';
import 'screens/otp_forget_password_verification_screen.dart';
import 'screens/request_otp_contact_number_screen.dart';
import 'screens/order_details_screen.dart';
import 'screens/support_faq_screen.dart';
import 'screens/booking_screen.dart';
import 'screens/booking_home_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/order_summary_screen.dart';
import 'screens/vendor_list_screen.dart';
import 'screens/payment_settings_screen.dart';
import 'screens/navigation_screen.dart';
import 'screens/wallet_balance_screen.dart';
import 'screens/chat_list_screen.dart';
import 'screens/chat_screen.dart';

// Initialize the plugin outside the class
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/splash': (context) => SplashScreen(),
        '/onboarding': (context) => OnboardingScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
        '/search': (context) => SearchScreen(),
        // '/service-selection': (context) => ServiceSelectionScreen(),
        '/vendor-item-detail': (context) => VendorItemDetailScreen(
              name: 'Sample Name',
              description: 'Sample Description',
              price: 99.99,
              rating: 4.5,
            ),
        '/order-tracking': (context) => OrderTrackingScreen(),
        '/review-rating': (context) => ReviewRatingScreen(),
        '/profile': (context) => ProfileScreen(),
        '/notifications': (context) => NotificationsScreen(),
        '/settings': (context) => SettingsScreen(),
        '/reset-password-screen': (context) => ResetPasswordScreen(),
        '/otp-verification-screen': (context) =>
            OtpForgetPasswordVerificationScreen(),
        '/request-otp-email-screen': (context) => RequestOtpScreen(),
        '/request-otp-contact-number-screen': (context) =>
            RequestOtpContactNumberScreen(),
        '/order-details-screen': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return OrderDetailsScreen(
            subtotal: args['subtotal'],
            qty: args['qty'],
            discount: args['discount'],
            tax: args['tax'],
            amount: args['amount'],
          );
        },
        '/support-faq-screen': (context) => SupportFAQScreen(),
        '/service-details-screen': (context) {
          final Map<String, dynamic> args = ModalRoute.of(context)!
              .settings
              .arguments as Map<String, dynamic>;
          final String serviceId =
              args['serviceId']; // Extract the receiverId from the map
          return ServiceDetailScreen(serviceId: serviceId);
        },
        '/booking-screen': (context) => BookingScreen(),
        '/booking-home-screen': (context) => BookingHomeScreen(),
        '/payment-screen': (context) => PaymentScreen(),
        '/order-summary-screen': (context) => OrderSummaryScreen(),
        '/vendor-list-screen': (context) => VendorListScreen(),
        '/otp-register-verification-screen': (context) =>
            OtpRegisterVerificationScreen(),
        '/payment-settings-screen': (context) => PaymentSettingsScreen(),
        '/navigation-screen': (context) => MainNavigationScreen(),
        '/wallet-balance-screen': (context) => WalletBalanceScreen(),
        '/chat-list-screen': (context) => ChatListScreen(),
        '/chat-screen': (context) {
          final Map<String, dynamic> args = ModalRoute.of(context)!
              .settings
              .arguments as Map<String, dynamic>;
          final String receiverId =
              args['receiverId']; // Extract the receiverId from the map
          final String name = args['name'];
          return ChatScreen(receiverId: receiverId, name: name);
        },
      },
    );
  }
}
