// lib/service_grid.dart

import 'package:flutter/material.dart';
import 'package:shublie_customer/models/service.dart'; // Import the Service model
import 'package:shublie_customer/components/x_service_card.dart'; // Make sure to import your ServiceCard widget

class ServiceGrid extends StatelessWidget {
  final List<Service> services; // List of services
  final Function(String serviceId) onAddToCart; // Callback for adding to cart

  const ServiceGrid({
    Key? key,
    required this.services,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Services')),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Two cards in a row
          mainAxisSpacing: 8.0, // Space between rows
          crossAxisSpacing: 8.0, // Space between columns
          childAspectRatio: 0.6, // Adjust aspect ratio for card size
        ),
        padding: const EdgeInsets.all(8.0),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return ServiceCard(
            serviceName: service.name,
            serviceImage: service.imageUrl,
            serviceCategory: service.category,
            onAddToCart: () => onAddToCart(service.id), // Pass service id to add to cart
          );
        },
      ),
    );
  }
}
