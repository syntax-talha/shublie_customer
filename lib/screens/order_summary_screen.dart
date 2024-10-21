import 'package:flutter/material.dart';
import 'package:shublie_customer/components/x_text.dart';
import 'package:shublie_customer/components/x_heading.dart';
import 'package:shublie_customer/utils/colors.dart'; // Ensure correct path to colors file

class OrderSummaryScreen extends StatefulWidget {
  @override
  _OrderSummaryScreenState createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  int _quantity = 1; // Default quantity
  final double _pricePerUnit = 50.0; // Example price per unit

  @override
  Widget build(BuildContext context) {
    double _totalPrice = _pricePerUnit * _quantity;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: XHeading(
          text: 'Order Details',
          color: Colors.white,
        ),
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView( // Added to prevent overflow
        child: Container(
          color: Colors.white, // Full white background
          padding: const EdgeInsets.all(16.0), // Padding to maintain spacing
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order Details Section
                XHeading(
                  text: 'Product XYZ',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 8),
                XText(
                  text: 'Date: 12th Sep, 2024',
                  fontSize: 16,
                ),
                SizedBox(height: 4),
                XText(
                  text: 'Time: 10:00 AM',
                  fontSize: 16,
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/onboarding2.jpg', // Replace with your image asset
                          fit: BoxFit.cover,
                          height: 150, // Increased height
                          width: 150,  // Increased width for proportion
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(thickness: 1, height: 30),

                // Quantity Selector Section
                XHeading(
                  text: 'Select Quantity',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (_quantity > 1) {
                          setState(() {
                            _quantity--;
                          });
                        }
                      },
                      icon: Icon(Icons.remove),
                      color: primaryColor,
                    ),
                    XText(
                      text: '$_quantity',
                      fontSize: 18,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _quantity++;
                        });
                      },
                      icon: Icon(Icons.add),
                      color: primaryColor,
                    ),
                  ],
                ),
                Divider(thickness: 1, height: 30),

                // Pricing Section
                XHeading(
                  text: 'Pricing',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    XText(
                      text: 'Price per Unit:',
                      fontSize: 16,
                    ),
                    XText(
                      text: '\$$_pricePerUnit',
                      fontSize: 16,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    XText(
                      text: 'Total:',
                      fontSize: 16,
                      // fontWeight: FontWeight.bold,
                    ),
                    XText(
                      text: '\$$_totalPrice',
                      fontSize: 16,
                      // fontWeight: FontWeight.bold,
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // Proceed Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle order confirmation logic here
                      Navigator.pushNamed(context, '/payment-screen');
                    },
                    child: Text('Proceed to Payment'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
