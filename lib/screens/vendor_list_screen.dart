import 'package:flutter/material.dart';
import 'package:shublie_customer/utils/colors.dart'; // Import your colors file for primaryColor

class Vendor {
  final String name;
  final String description;
  final String imageUrl;
  final double rating;
  final int reviewCount;

  Vendor({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
  });
}

class VendorListScreen extends StatelessWidget {
  final List<Vendor> vendors = [
    Vendor(
      name: 'Shine Masters',
      description: 'Offering high-quality shoe polishing services with a focus on premium care and attention to detail.',
      imageUrl: 'assets/images/profile-2.png',
      rating: 4.5,
      reviewCount: 120,
    ),
    Vendor(
      name: 'Leather Luxe',
      description: 'Specializing in leather care and maintenance, ensuring your shoes remain supple and pristine.',
      imageUrl: 'assets/images/profile-1.png',
      rating: 4.7,
      reviewCount: 98,
    ),
    Vendor(
      name: 'Polish Pro',
      description: 'Expert in premium shoe cleaning and restoration, bringing your shoes back to their original glory.',
      imageUrl: 'assets/images/profile-3.png',
      rating: 4.8,
      reviewCount: 150,
    ),
    Vendor(
      name: 'Quick Shine',
      description: 'Known for quick and efficient shoe polishing services that get you back on your feet in no time.',
      imageUrl: 'assets/images/profile.png',
      rating: 4.3,
      reviewCount: 85,
    ),
    Vendor(
      name: 'Luxury Soles',
      description: 'Offers personalized shoe care with a touch of luxury, catering to the most discerning clients.',
      imageUrl: 'assets/images/vendor5.png',
      rating: 4.9,
      reviewCount: 175,
    ),
    Vendor(
      name: 'Elite Polishers',
      description: 'Elite shoe care services specializing in high-end footwear and accessories.',
      imageUrl: 'assets/images/vendor6.png',
      rating: 4.6,
      reviewCount: 110,
    ),
    Vendor(
      name: 'Urban Shine',
      description: 'Bringing urban flair to shoe polishing with modern techniques and top-tier products.',
      imageUrl: 'assets/images/vendor7.png',
      rating: 4.4,
      reviewCount: 90,
    ),
    Vendor(
      name: 'Classic Care',
      description: 'Traditional shoe care with a focus on classic techniques and timeless service.',
      imageUrl: 'assets/images/vendor8.png',
      rating: 4.7,
      reviewCount: 130,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Available Vendors',
          style: TextStyle(color: Colors.white), // Set the title text color to white
        ),
        centerTitle: true,
        backgroundColor: primaryColor, // Use primary color
      ),
      body: ListView.builder(
        itemCount: vendors.length,
        itemBuilder: (context, index) {
          final vendor = vendors[index];
          return VendorListItem(vendor: vendor, primaryColor: primaryColor);
        },
      ),
    );
  }
}

class VendorListItem extends StatelessWidget {
  final Vendor vendor;
  final Color primaryColor;

  VendorListItem({required this.vendor, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // No rounded corners
      ),
      elevation: 5,
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        leading: CircleAvatar(
          backgroundImage: AssetImage(vendor.imageUrl),
          radius: 30.0,
        ),
        title: Text(
          vendor.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              vendor.description,
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 20.0),
                SizedBox(width: 4.0),
                Text(
                  '${vendor.rating} (${vendor.reviewCount} reviews)',
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: primaryColor,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VendorDetailScreen(vendor: vendor, primaryColor: primaryColor),
            ),
          );
        },
      ),
    );
  }
}

class VendorDetailScreen extends StatelessWidget {
  final Vendor vendor;
  final Color primaryColor;

  VendorDetailScreen({required this.vendor, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(vendor.name),
        backgroundColor: primaryColor, // Use primary color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(vendor.imageUrl),
            SizedBox(height: 16.0),
            Text(
              vendor.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 24.0),
                SizedBox(width: 4.0),
                Text(
                  '${vendor.rating} (${vendor.reviewCount} reviews)',
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              vendor.description,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
