import 'package:flutter/material.dart';
import 'package:shublie_customer/components/x_text.dart';
import 'package:shublie_customer/components/x_heading.dart';
import 'package:shublie_customer/components/x_button.dart';
import 'package:shublie_customer/utils/colors.dart';

class WalletBalanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      appBar: AppBar(
        title: XHeading(
          text: 'Wallet Balance',
          color: Colors.white,
        ),
        backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Wallet Balance Card
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  XHeading(
                    text: 'Current Balance',
                    fontSize: 18,
                    color: primaryColor,
                  ),
                  SizedBox(height: 10),
                  XHeading(
                    text: '\$1,250.00', // Example balance
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),

            // Recent Transactions
            XHeading(
              text: 'Recent Transactions',
              fontSize: 18,
              color: primaryColor,
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: ListView(
                children: [
                  _buildTransactionTile(
                    title: 'Payment Received',
                    subtitle: 'From John Doe',
                    amount: '+ \$50.00',
                    color: Colors.green,
                  ),
                  _buildTransactionTile(
                    title: 'Purchase',
                    subtitle: 'Payment for service',
                    amount: '- \$30.00',
                    color: Colors.red,
                  ),
                  _buildTransactionTile(
                    title: 'Refund',
                    subtitle: 'Refund from transaction',
                    amount: '+ \$20.00',
                    color: Colors.green,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: XButton(
                    onPressed: () {
                      // Handle Add Funds action
                      Navigator.pushNamed(context, '/add-funds');
                    },
                    text: 'Add Funds',
                    buttonType: ButtonType.filled,
                    color: primaryColor, // Set button color to primary color
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: XButton(
                    onPressed: () {
                      // Handle View Transaction History action
                      Navigator.pushNamed(context, '/transaction-history-screen');
                    },
                    text: 'View History',
                    buttonType: ButtonType.filled,
                    color: Colors.grey[600], // Set button color to grey
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionTile({
    required String title,
    required String subtitle,
    required String amount,
    required Color color,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              XText(
                text: title,
                fontSize: 16,
                // fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 5.0),
              XText(
                text: subtitle,
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ],
          ),
          XText(
            text: amount,
            fontSize: 16,
            // fontWeight: FontWeight.bold,
            color: color,
          ),
        ],
      ),
    );
  }
}
