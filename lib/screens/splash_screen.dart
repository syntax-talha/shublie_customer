import 'package:flutter/material.dart';
import 'package:shublie_customer/components/App/x_app_logo.dart';
import 'package:shublie_customer/components/background_screen.dart';
import 'package:shublie_customer/utils/colors.dart';
import 'package:shublie_customer/utils/images.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });

    return BackgroundScreen(
      backgroundImage: bgImage_6,
      overlayColor: Colors.white.withOpacity(0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          XAppLogo(),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              "Transform your shoes, transform your image",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          const CircularProgressIndicator(
            color: primaryColor,
          ),
        ],
      ),
    );
  }
}
