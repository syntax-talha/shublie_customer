import 'dart:convert'; // Make sure to import this for jsonDecode
import 'package:flutter/material.dart';
import 'package:shublie_customer/utils/colors.dart';
import 'package:shublie_customer/utils/configs.dart';

class VendorCard extends StatelessWidget {
  final String vendorName;
  final String vendorId;
  final String vendorImage; // Image for the avatar (path only)
  final String vendorAddress;

  // Base URL for the images

  const VendorCard({
    required this.vendorName,
    required this.vendorId,
    required this.vendorImage, // Path to the image
    required this.vendorAddress,
  });

  @override
  Widget build(BuildContext context) {
    final addressWords = vendorAddress.split(' ');
    final displayAddress = addressWords.take(4).join(' ');

    // Construct the image URL or use a fallback image
    String serviceImage = vendorImage.isNotEmpty
        ? '${baseUrl}/${vendorImage}' // Assuming vendorImage is the path like 'images/profile-2.png'
        : 'https://via.placeholder.com/150'; // Fallback image

    return Container(
      width: 150, // Adjusted width to fit two cards
      margin: EdgeInsets.only(top: 35, left: 0.0), // Adjusted margin
      child: Stack(
        clipBehavior: Clip.none, // Allow overflow of the CircleAvatar
        children: [
          // Bottom half with white background
          Container(
            height:
                125, // Adjusted height for the card (ensure it accommodates the overflow)
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Color.fromARGB(221, 211, 205, 205), // Border color
                width: 2, // Border width
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 35), // Space for the image overlap
                Text(
                  vendorName,
                  maxLines: 1,
                  // Limit to one line
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13, // Adjusted font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  displayAddress.replaceAll(RegExp(r'[\"//\\]'), ''),
                  maxLines: 1,
                  // Limit to one line
                  overflow: TextOverflow.ellipsis, // Address displayed here
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600], // Light grey color for address
                  ),
                ),
                SizedBox(height: 8),
                // Row to include buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Center buttons
                  children: [
                    SizedBox(width: 6), // Space between buttons
                    IconButton(
                      onPressed: () {
                        // Navigate to the chat screen
                        Navigator.of(context).pushNamed(
                          '/chat-screen',
                          arguments: {
                            'receiverId':
                                vendorId, // Pass vendor ID to chat screen
                            'name':
                                vendorName, // Pass vendor name to chat screen
                          },
                        );
                      },
                      icon: Icon(Icons.email), // Message icon
                      color: primaryColor, // Color for the icon
                    ),
                    SizedBox(width: 6), // Space between buttons
                    IconButton(
                      onPressed: () {
                        // Handle call button tap
                      },
                      icon: Icon(Icons.call),
                      color: Colors.green, // Color for the icon
                    ),
                    SizedBox(width: 6), // Space between buttons
                    IconButton(
                      onPressed: () {
                        // Handle location button tap
                      },
                      icon: Icon(Icons.location_on),
                      color: Colors.red, // Color for the icon
                    ),
                  ],
                ),
              ],
            ),
          ),
          // CircleAvatar positioned above the card
          Positioned(
            top: -30, // Position the CircleAvatar above the card
            left: 0,
            right: 0,
            child: Center(
              child: CircleAvatar(
                radius: 30, // Smaller avatar
                backgroundColor: Color.fromARGB(
                    255, 245, 68, 3), // Optional: for better visibility
                child: ClipOval(
                  child: Image.network(
                    serviceImage,
                    // Use the constructed image URL
                    fit: BoxFit.cover,
                    width: 90, // Adjust width
                    height: 90, // Adjust height
                    errorBuilder: (context, error, stackTrace) {
                      // Placeholder in case of error
                      return Icon(Icons.error, color: Colors.red, size: 45);
                    },
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
