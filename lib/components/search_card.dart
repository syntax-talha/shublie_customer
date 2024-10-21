import 'package:flutter/material.dart';
import 'package:shublie_customer/utils/configs.dart'; // Import configs for baseUrl
import 'dart:convert';

class SearchCard extends StatelessWidget {
  final Map<String, dynamic> data; // The data could be service, vendor, or category
  final String type; // Type of the data: "service", "vendor", "category"
  
  const SearchCard({
    Key? key,
    required this.data,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case 'service':
        return _buildServiceCard(data);
      case 'vendor':
        return _buildVendorCard(data);
      case 'category':
        return _buildCategoryCard(data);
      default:
        return SizedBox.shrink(); // Return empty widget if type is not recognized
    }
  }

  // Build Service Card
  Widget _buildServiceCard(Map<String, dynamic> service) {
    String serviceName = service['title'] ?? 'No Name';
    String serviceDescription = service['description'] ?? 'No Description';
    String serviceCategory = service['category']?['name']?.toString() ?? 'No Category'; // Safely access nested keys
    String serviceImage =
        (service['images'] != null && jsonDecode(service['images']).isNotEmpty)
            ? '${baseUrl}${jsonDecode(service['images'])[0]}'
            : 'https://via.placeholder.com/150'; // Fallback image
    double servicePrice = double.tryParse(service['price'].toString()) ?? 0.0;

    return Container(
      width: 160,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey, width: 1),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)],
      ),
      child: Column(
        children: [
          Image.network(
            serviceImage,
            fit: BoxFit.cover,
            height: 96,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(serviceCategory, style: const TextStyle(color: Colors.orange)),
                Text(serviceName, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('\$${servicePrice.toStringAsFixed(2)}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Build Vendor Card
  Widget _buildVendorCard(Map<String, dynamic> vendor) {
    String vendorName = vendor['vendorName'] ?? 'Unknown Vendor';
    String vendorImage = (vendor['vendorImage']?.isNotEmpty ?? false)
        ? '${baseUrl}/${vendor['vendorImage']}'
        : 'https://via.placeholder.com/150'; // Fallback image if vendorImage is null or empty
    String vendorAddress = vendor['vendorAddress'] ?? 'No Address';

    return Container(
      width: 150,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey, width: 1),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)],
      ),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(vendorImage),
            radius: 30,
            onBackgroundImageError: (error, stackTrace) => const Icon(Icons.error),
          ),
          const SizedBox(height: 10),
          Text(vendorName, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(vendorAddress),
        ],
      ),
    );
  }

  // Build Category Card
  Widget _buildCategoryCard(Map<String, dynamic> category) {
    String categoryName = category['categoryName'] ?? 'Unknown Category';
    String categoryImage = (category['categoryImage'] != null)
        ? '$baseUrl/${category['categoryImage']}'
        : 'https://via.placeholder.com/150'; // Fallback image

    return Container(
      width: 100,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey, width: 1),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)],
      ),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 2 / 1,
            child: Image.network(
              categoryImage,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(height: 10),
          Text(categoryName, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
