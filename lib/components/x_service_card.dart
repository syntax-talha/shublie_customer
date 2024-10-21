import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shublie_customer/utils/configs.dart';
import 'x_atc_button.dart'; // Make sure to import your custom button

class ServiceCard extends StatelessWidget {
  final Map<String, dynamic> service;

  const ServiceCard({
    Key? key,
    required this.service,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String serviceName = service['title'] ?? 'No Name';
    String serviceDescription = service['description'] ?? 'No Description';
    String serviceCategory = service['category']['name'].toString();
    // String serviceCategory = service['id'].toString();
    String serviceImage =
        (service['images'] != null && jsonDecode(service['images']).isNotEmpty)
            ? '${baseUrl}${jsonDecode(service['images'])[0]}'
            : 'https://via.placeholder.com/150';
// Fallback image

    double servicePrice = 0.0;
    if (service['price'] is String) {
      servicePrice =
          double.tryParse(service['price']) ?? 0.0; // Convert to double
    } else if (service['price'] is double) {
      servicePrice = service['price']; // Use as is if already a double
    }
    return Container(
      width: 160,
      height: 187,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color:
              Color.fromARGB(221, 138, 132, 132), // Set the border color to red
          width: 1, // Set the border width
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 96,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
              child: Image.network(
                serviceImage,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade200,
                    child: const Center(child: Icon(Icons.error)),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  serviceCategory,
                  maxLines: 1, // Limit to one line
                  overflow:
                      TextOverflow.ellipsis, // Show ellipsis if text overflows
                  style:
                      TextStyle(fontSize: 12.0, color: const Color(0xFFEA5D25)),
                ),
                const SizedBox(height: 4.0),
                Text(
                  serviceName,
                  maxLines: 1, // Limit to one line
                  overflow:
                      TextOverflow.ellipsis, // Show ellipsis if text overflows
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${servicePrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CustomAddToCartButton(
                        onPressed: () {
                          print('Added $serviceName to cart');
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServices(List<Map<String, dynamic>> services) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: services.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: ServiceCard(
              service: services[index],
            ),
          );
        },
      ),
    );
  }
}
