import 'package:flutter/material.dart';

class VendorItemDetailScreen extends StatelessWidget {
  final String name;
  final String description;
  final double price;
  final double rating;

  VendorItemDetailScreen({
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Vendor/Item Name
            Text(
              name,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),

            // Description
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16.0),

            // Price
            Text(
              'Price: \$${price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),

            // Rating
            Row(
              children: <Widget>[
                Icon(Icons.star, color: Colors.yellow[700]),
                Text(
                  ' ${rating.toStringAsFixed(1)}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.0),

            // Special Instructions Field
            TextField(
              decoration: InputDecoration(
                labelText: 'Special Instructions',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 24.0),

            // Action Button
            ElevatedButton(
              onPressed: () {
                // Handle proceed or add to cart action
                Navigator.pop(context);
              },
              child: Text('Proceed'),
            ),
          ],
        ),
      ),
    );
  }
}
