import 'package:flutter/material.dart';
import 'package:shublie_customer/utils/colors.dart'; // Import your colors file
import 'package:shublie_customer/components/x_button.dart'; // Import your XButton component

class OrderHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom AppBar-like Container with Back Button
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16.0),
            decoration: BoxDecoration(
              color: primaryColor, // Use primary color
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0)),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context); // Navigate back
                    },
                  ),
                ),
                Center(
                  child: Text(
                    'Order History',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          // Spacer to leave some space from the top
          SizedBox(height: 20),
          // Order History Cards
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  _buildOrderCard(context, 'Order #1: Product Name, Quantity, Price'),
                  SizedBox(height: 10),
                  _buildOrderCard(context, 'Order #2: Product Name, Quantity, Price'),
                  SizedBox(height: 10),
                  _buildOrderCard(context, 'Order #3: Product Name, Quantity, Price'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, String orderDetails) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image container
            Container(
              height: 100.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: AssetImage('assets/images/sample_image.png'), // Update with your image asset
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            // Order details text
            Text(
              orderDetails,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            // Reorder button
            Align(
              alignment: Alignment.centerRight,
              child: XButton(
                text: 'Reorder',
                onPressed: () {
                  Navigator.pushNamed(context, '/order-summary-screen'); // Link to Order Summary screen
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
