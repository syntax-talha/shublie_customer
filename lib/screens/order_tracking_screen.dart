import 'package:flutter/material.dart';
import 'package:shublie_customer/components/x_button.dart';
import 'package:shublie_customer/utils/colors.dart';
import 'package:shublie_customer/components/x_dialog.dart';
import 'package:shublie_customer/components/x_text.dart';
import 'package:shublie_customer/components/x_heading.dart';

class OrderTrackingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: XHeading(text: 'Order Tracking', color: Colors.white),
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Status Container
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
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
                  XHeading(
                    text: 'Current Status of Service',
                    fontSize: 18,
                  ),
                  SizedBox(height: 16.0),
                  // Vertical Timeline with Dotted Line
                  Column(
                    children: [
                      _buildStatusTile(
                        context,
                        title: 'Order Placed',
                        time: '1:00 PM',
                        isDone: true,
                      ),
                      _buildStatusTile(
                        context,
                        title: 'Order Accepted',
                        time: '1:30 PM',
                        isDone: true,
                      ),
                      _buildStatusTile(
                        context,
                        title: 'Item Picked Up',
                        time: '2:00 PM',
                        isDone: true,
                      ),
                      _buildStatusTile(
                        context,
                        title: 'Work in Progress',
                        time: '2:30 PM',
                        isDone: false,
                        isOngoing: true,
                      ),
                      _buildStatusTile(
                        context,
                        title: 'Task Finished',
                        time: '3:00 PM',
                        isDone: false,
                      ),
                      _buildStatusTile(
                        context,
                        title: 'Delivered',
                        time: '3:15 PM',
                        isDone: false,
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  // Estimated Remaining Time
                  Align(
                    alignment: Alignment.centerRight,
                    child: XText(
                      text: 'Estimated Remaining Time: 45 mins',
                      fontSize: 16,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            // Map Placeholder
            Container(
              height: 150,
              color: Colors.grey[300],
              child: Center(child: XText(text: 'Live Tracking Map Placeholder')),
            ),
            SizedBox(height: 16.0),
            // Contact Service Provider Button
            Align(
              alignment: Alignment.centerRight,
              child: XButton(
                text: 'Contact Provider',
                onPressed: () {
                  // Handle contact action
                },
                buttonType: ButtonType.elevated,
                color: primaryColor,
                textColor: Colors.white,
              ),
            ),
            SizedBox(height: 8.0),
            // Cancel Order Button
            XButton(
              text: 'Cancel Order',
              onPressed: () {
                _showCancelOrderDialog(context);
              },
              buttonType: ButtonType.elevated,
              color: Colors.red,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  void _showCancelOrderDialog(BuildContext context) {
    XDialog.show(
      context,
      title: 'Cancel Order',
      content: 'Are you sure you want to cancel this order?',
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Dismiss the dialog
          },
          child: XText(text: 'No'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Dismiss the dialog and perform cancel action
            // Perform additional cancellation logic here if needed
          },
          style: ElevatedButton.styleFrom(),
          child: XText(text: 'Yes'),
        ),
      ],
    );
  }

  Widget _buildStatusTile(BuildContext context,
      {required String title, required String time, required bool isDone, bool isOngoing = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(
              isDone ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isDone ? Colors.green : (isOngoing ? Colors.yellow : Colors.grey),
              size: 24.0,
            ),
            Container(
              height: 40.0,
              child: VerticalDivider(
                color: isDone || isOngoing ? Colors.green : Colors.grey,
                thickness: 2.0,
                width: 2.0,
              ),
            ),
          ],
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              XText(
                text: title,
                fontSize: 16.0,
                // fontWeight: FontWeight.bold,
                color: isDone ? Colors.green : (isOngoing ? Colors.yellow[700] : Colors.black),
              ),
              XText(
                text: time,
                fontSize: 14.0,
                color: Colors.grey,
              ),
              SizedBox(height: 8.0),
            ],
          ),
        ),
      ],
    );
  }
}
