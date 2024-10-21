import 'package:flutter/material.dart';
import 'package:shublie_customer/components/x_button.dart'; // Update with the correct path to your XButton component
import 'package:shublie_customer/components/x_text_field.dart'; // Update with the correct path to your XTextField component
import 'package:shublie_customer/screens/order_tracking_screen.dart'; // Import OrderTrackingScreen
import 'package:shublie_customer/utils/colors.dart'; // Import your colors file for primaryColor

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // List of payment options
  List<Map<String, String>> _paymentOptions = [
    {'cardNumber': '**** **** **** 1234', 'cardHolder': 'John Doe'},
    {'cardNumber': '**** **** **** 5678', 'cardHolder': 'Jane Smith'},
  ];

  // Variable to store the selected payment option
  String? _selectedPaymentOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Custom AppBar-like Container with Back Arrow
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16.0),
              color: primaryColor, // Use primary color for the AppBar-like container
              child: Stack(
                children: [
                  // Back Arrow
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop(); // Handle back navigation
                      },
                    ),
                  ),
                  // Title
                  Center(
                    child: Text(
                      'Payment',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30), // Space between the AppBar and the content

            // Saved Payment Options Container
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.zero, // No rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Saved Payment Options',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16.0),

                    // List of Saved Payment Options
                    Column(
                      children: _paymentOptions.map((option) {
                        return CheckboxListTile(
                          title: Text(option['cardNumber']!),
                          subtitle: Text(option['cardHolder']!),
                          value: _selectedPaymentOption == option['cardNumber'],
                          onChanged: (bool? selected) {
                            setState(() {
                              if (selected == true) {
                                _selectedPaymentOption = option['cardNumber'];
                              } else {
                                _selectedPaymentOption = null;
                              }
                            });
                          },
                          activeColor: primaryColor,
                          controlAffinity: ListTileControlAffinity.leading, // Place checkbox on the left
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20), // Space before the Payment Details Container

            // Payment Details Container
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.zero, // No rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter Payment Details',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16.0),

                    // Card Number Input Field
                    XTextField(
                      controller: TextEditingController(),
                      labelText: 'Card Number',
                      icon: Icons.credit_card,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 10),

                    // CVC Input Field
                    XTextField(
                      controller: TextEditingController(),
                      labelText: 'CVC',
                      icon: Icons.lock,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 10),

                    // Expiry Date Input Field
                    XTextField(
                      controller: TextEditingController(),
                      labelText: 'Expiry Date (MM/YYYY)',
                      icon: Icons.calendar_today,
                      keyboardType: TextInputType.datetime,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20), // Space before the Promo Code input

            // Promo Code Input Field (outside the container)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: XTextField(
                controller: TextEditingController(),
                labelText: 'Promo Code',
                icon: Icons.local_offer,
                keyboardType: TextInputType.text,
              ),
            ),

            SizedBox(height: 30), // Space before the Pay Now button

            // Pay Now Button
            Center(
              child: XButton(
                text: 'Pay Now',
                onPressed: () {
                  // Navigate to OrderTrackingScreen on payment confirmation
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrderTrackingScreen()),
                  );
                },
                buttonType: ButtonType.elevated,
                color: primaryColor, // Use primary color for the button
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
