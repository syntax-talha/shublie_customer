import 'package:flutter/material.dart';
import 'package:shublie_customer/components/x_radio_button.dart'; // Update with the correct path to your XRadioButton component
import 'package:shublie_customer/utils/colors.dart'; // Import your primary color

class OrderDetailsScreen extends StatefulWidget {
  final double subtotal;
  final int qty;
  final double discount;
  final double tax;
  final double amount;

  OrderDetailsScreen({
    required this.subtotal,
    required this.qty,
    required this.discount,
    required this.tax,
    required this.amount,
  });

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  String? selectedPaymentMethod; // Set the default value here
  @override
  void initState() {
    super.initState();
    selectedPaymentMethod = 'Pay with Stripe'; // Set the default value here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor, // Use your primary color
        iconTheme: IconThemeData(
          color: Colors.white, // Set the back arrow color to white
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Price Detail',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Add a color for better visibility
              ),
            ),
            SizedBox(height: 6), // Added height for better spacing
            _buildOrderDetailRow('Quantity:', widget.qty.toString()),
            Divider(),
            _buildOrderDetailRow(
                'Subtotal:', '\$${widget.subtotal.toStringAsFixed(2)}'),
            Divider(),
            _buildOrderDetailRow(
                'Discount:', '\$${widget.discount.toStringAsFixed(2)}'),
            Divider(),
            _buildOrderDetailRow('Tax:', '\$${widget.tax}'),
            Divider(),
            _buildOrderDetailRow(
                'Total Amount:', '\$${widget.amount.toStringAsFixed(2)}',
                isTotal: true),
            const SizedBox(height: 20),
            Text(
              'Payment Method',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            _buildPaymentOption(
                'Pay with Stripe'), // Only one payment method available
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                ),
              ),
              onPressed: _handlePayment, // Handle payment button click
              child: Text(
                'Confirm Payment',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderDetailRow(String title, String value,
      {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isTotal ? 14 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 14 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.red : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        XRadioButton<String>(
          value: label,
          groupValue: selectedPaymentMethod.toString(),
          onChanged: (value) {
            setState(() {
              selectedPaymentMethod = value; // Update selected method
            });
          },
          activeColor: primaryColor,
        ),
        SizedBox(width: 8),
        Text(label), // Display the payment method label
      ],
    );
  }

  void _handlePayment() {
    if (selectedPaymentMethod != null) {
      print("Processing payment with: $selectedPaymentMethod");
      // Add logic to initiate payment with Stripe
    } else {
      print("Please select a payment method");
    }
  }
}
