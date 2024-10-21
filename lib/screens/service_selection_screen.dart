import 'package:flutter/material.dart';
import 'package:shublie_customer/components/x_button.dart'; // Update with the correct path to your XButton component
import 'package:shublie_customer/screens/x_list_tile.dart'; // Assuming you have an XListTile component, update the path

class ServiceSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Service'),
        centerTitle: true,
        backgroundColor: Colors.blue, // Updated to match previous screen design
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Service List Title
            Text(
              'Available Services:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),

            // Service List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
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
                children: <Widget>[
                  _buildServiceItem(context, 'Service 1'),
                  _buildServiceItem(context, 'Service 2'),
                  _buildServiceItem(context, 'Service 3'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem(BuildContext context, String serviceName) {
    return XListTile(
      title: serviceName,  // Pass serviceName directly as a String
      onTap: () {
        // Navigate to service detail screen or add to cart
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServiceDetailScreen(serviceName: serviceName),
          ),
        );
      },
    );
  }
}

class ServiceDetailScreen extends StatelessWidget {
  final String serviceName;

  ServiceDetailScreen({required this.serviceName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(serviceName),
        centerTitle: true,
        backgroundColor: Colors.blue, // Updated to match previous screen design
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Service Details
            Text(
              'Details for $serviceName',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Description of $serviceName.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 24.0),

            // Add to Cart Button
            XButton(
              text: 'Add to Cart',
              onPressed: () {
                // Handle add to cart or continue with the service
                Navigator.pop(context);
              },
              buttonType: ButtonType.elevated,
              color: Colors.blue, // Updated to match button color in previous screens
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
