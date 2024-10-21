import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Example data
    final services = [
      {'name': 'Service 1', 'price': 20.0},
      {'name': 'Service 2', 'price': 35.0},
    ];
    final salesTaxRate = 0.07;

    double totalAmount = services.fold(0, (sum, item) => sum + item['price']);
    double salesTax = totalAmount * salesTaxRate;
    double grandTotal = totalAmount + salesTax;

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Selected Services List
            Text(
              'Selected Services:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView(
                children: services.map((service) {
                  return ListTile(
                    title: Text(service['name']),
                    trailing: Text('\$${service['price'].toStringAsFixed(2)}'),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 16.0),

            // Special Instructions Field
            TextField(
              decoration: InputDecoration(
                labelText: 'Special Instructions',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16.0),

            // Total Amount
            Text(
              'Subtotal: \$${totalAmount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              'Sales Tax (7%): \$${salesTax.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Total: \$${grandTotal.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24.0),

            // Confirm Order Button
            ElevatedButton(
              onPressed: () {
                // Handle order confirmation
                // Example: Navigator.pushNamed(context, '/orderConfirmation');
              },
              child: Text('Confirm Order'),
            ),
          ],
        ),
      ),
    );
  }
}
