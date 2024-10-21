import 'package:flutter/material.dart';
import 'package:shublie_customer/utils/configs.dart'; // Import configs where baseUrl is defined

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final String categoryImage; // Image path (not full URL)
  final String? categoryDescription;
  final VoidCallback? onAddToCart;

  const CategoryCard({
    required this.categoryName,
    required this.categoryImage,
    this.categoryDescription,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    // Replace backslashes with forward slashes in the image path
    final fullImageUrl =
        '$baseUrl/$categoryImage'; // Concatenate base URL with the normalized image path
    return Container(
      width: 100,
      margin: EdgeInsets.only(left: 0), // Margin for spacing
      padding: EdgeInsets.all(1.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Color.fromARGB(221, 211, 205, 205), // Border color
          width: 2, // Border width
        ),
        borderRadius:
            BorderRadius.circular(8), // Slightly increased border radius
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // Shadow color
            blurRadius: 5, // Shadow blur
            offset: Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Category Image with 2:1 Aspect Ratio
          AspectRatio(
            aspectRatio: 2 / 1,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(8)), // Rounded top corners
              child: Image.network(
                fullImageUrl, // Use the concatenated full URL
                fit: BoxFit.cover, // Cover the entire area
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300], // Placeholder color
                    child: Center(
                        child:
                            Icon(Icons.error, color: Colors.red)), // Error icon
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 5),

          // Category Name
          Container(
            padding: EdgeInsets.all(1.0),
            child: Text(
              categoryName,
              maxLines: 1,
              // Limit to one line
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Better contrast color
              ),
            ),
          ),
        ],
      ),
    );
  }
}
