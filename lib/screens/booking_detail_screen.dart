import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shublie_customer/components/x_text.dart';
import 'package:shublie_customer/components/x_heading.dart';
import 'package:shublie_customer/components/x_button.dart';
import 'package:shublie_customer/screens/service_details_screen.dart';
import 'package:shublie_customer/utils/colors.dart';
import 'package:shublie_customer/utils/configs.dart';
import 'package:intl/intl.dart';

class BookingDetailScreen extends StatelessWidget {
  final Map<String, dynamic> booking;
  final String baseURL = baseUrl;

  BookingDetailScreen({Key? key, required this.booking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> images = [];
    if (booking['service']?['images'] != null &&
        booking['service']['images'].isNotEmpty) {
      images =
          jsonDecode(booking['service']['images']); // Decode the JSON string
    }

    // Parse created_at date
    DateTime createdAt = DateTime.parse(booking['created_at']);

    // Format the date to "October-10-2024"
    String formattedDate =
        DateFormat('MMMM dd, yyyy').format(createdAt.toLocal()); // Format date
    String formattedTime =
        "${createdAt.toLocal()}".split(' ')[1].substring(0, 5); // Format time

    return Scaffold(
      appBar: AppBar(
        title: XHeading(
          text: 'Booking Details',
          color: Colors.white,
        ),
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(
          color: Colors.white, // Set the back arrow color to white
        ),
      ),
      body: Column(
        children: [
          // Pending status message outside the padding with full width
          if (booking["status"] == "pending") ...[
            Container(
              width: double.infinity, // Make container full width
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.yellow.shade100,
                borderRadius: BorderRadius.circular(2),
              ),
              child: XText(
                text: 'Waiting for provider approval',
                fontSize: 14.0,
                color: Colors.amber.shade800,
              ),
            ),
            SizedBox(height: 10), // Space after the message
          ],

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: ListView(
                children: [
                  _buildBookingIdRow(),
                  Divider(),
                  _buildServiceRow(
                      images, formattedDate, formattedTime, context),
                  SizedBox(height: 8.0),

                  Divider(),
                  // Provider information card
                  _buildProviderInfoCard(),
                  SizedBox(height: 8.0),

                  // Price and other details card
                  _buildPriceDetailsCard(),
                  SizedBox(height: 8.0),

                  // Reviews card
                  _buildReviewsCard(),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
          // Static Track Order Button
          _buildButtons(),
        ],
      ),
    );
  }

  Widget _buildBookingIdRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Booking ID",
              style: TextStyle(
                fontSize: 14.0,
                color: const Color.fromARGB(255, 186, 184, 184),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Text(
            "#${booking["id"]?.toString() ?? 'N/A'}", // Added '#' before the ID
            style: TextStyle(
              fontSize: 14.0,
              color: const Color.fromARGB(
                  255, 0, 123, 255), // Change this to your desired color
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceRow(List<dynamic> images, String formattedDate,
      String formattedTime, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking["service"]?["title"] ?? '',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                XText(
                  text: 'Date: $formattedDate',
                  fontSize: 14.0,
                  color: Colors.grey.shade600,
                ),
                XText(
                  text: 'Time: $formattedTime',
                  fontSize: 14.0,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
          ),
          SizedBox(width: 10.0),
          GestureDetector(
            onTap: () {
              String serviceId = booking["service"]["id"].toString();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ServiceDetailScreen(
                    serviceId: serviceId,
                    showOrderButton:
                        false, // Set to false when coming from booking
                  ),
                ),
              );
            },
            child: Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                image: DecorationImage(
                  image: images.isNotEmpty
                      ? NetworkImage('$baseURL${images[0]}')
                      : AssetImage('assets/default.jpg') as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProviderInfoCard() {
    // Construct the image URL
    final String imageUrl =
        '$baseUrl/${booking['service']['provider']['profile_image']}';

    return Container(
      color: Color.fromARGB(
          255, 255, 255, 255), // Change this to your desired color

      child: Padding(
        padding: const EdgeInsets.only(left: 0, right: 0),
        child: Column(
          // Use Column to stack the text and the Row
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // About Provider Text
                  Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16.0), // Adjust padding as needed
  child: Text(
    "About Provider", // Title
    style: TextStyle(
      fontSize: 16, // Adjust font size as needed
      fontWeight: FontWeight.bold, // Bold text for emphasis
      color: Colors.black, // Text color
    ),
  ),
),
            SizedBox(height: 8), // Space between title and content

            // Provider Info Row
            Row(
              children: [
                SizedBox(width: 10),
                // Provider Image
                ClipOval(
                  child: Image.network(
                    imageUrl, // Use the full URL for the provider's image
                    width: 60, // Set width for the image
                    height: 60, // Set height for the image
                    fit: BoxFit.cover, // Fit the image to the circle
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error,
                          size:
                              50); // Display an error icon if the image fails to load
                    },
                  ),
                ),
                SizedBox(width: 20), // Space between image and text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      XText(
                        text: booking['service']['provider']['first_name'] +
                            ' ' +
                            booking['service']['provider']['last_name'],
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < 4 ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 16,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                // Add Icon Buttons
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.phone, color: Colors.green),
                  onPressed: () {
                    // Handle call action
                    print('Call pressed');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.email, color: Colors.blue),
                  onPressed: () {
                    // Handle chat action
                    print('Chat pressed');
                  },
                ),
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

Widget _buildPriceDetailsCard() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5.0), // Horizontal margin
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[100], // Lighter grey color
        borderRadius: BorderRadius.circular(12.0), // Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            XHeading(
              text: 'Price Details',
              fontSize: 16.0,
              color: Colors.black,
            ),
            SizedBox(height: 8.0),
            _buildDetailRow(
              'Original Price', 
              '\$${booking["amount"] ?? '0.00'}',
              color: Colors.green
            ),
            Divider(thickness: 1, color: Colors.grey[150], endIndent: 0),
            _buildDetailRow(
              'Discount', 
              '- \$${booking["discount"] ?? '0.00'}',
              color: Colors.red
            ),
            Divider(thickness: 1, color: Colors.grey[150], endIndent: 0),
            _buildDetailRow(
              'Subtotal', 
              '\$${booking["subtotal_amount"] ?? '0.00'}',
              color: Colors.black
            ),
            Divider(thickness: 1, color: Colors.grey[150], endIndent: 0),
            _buildDetailRow(
              'Tax', 
              '\$${booking["tax"] ?? '0.00'}',
              color: Colors.black
            ),
            Divider(thickness: 1, color: Colors.grey[150], endIndent: 0),
            _buildDetailRow(
              'Total', 
              '\$${booking["total_amount"] ?? '0.00'}',
              color: Colors.black
            ),
          ],
        ),
      ),
    ),
  );
}



  List<Map<String, dynamic>> dummyReviews = [
    {
      "user_name": "John Doe",
      "review": "Great service!",
      "rating": 5,
      "profile_image":
          "https://dummyimage.com/100x100/000/fff", // Dummy profile image
    },
    {
      "user_name": "Jane Smith",
      "review": "Very satisfied with the service.",
      "rating": 4,
      "profile_image":
          "https://dummyimage.com/100x100/000/fff", // Dummy profile image
    },
    {
      "user_name": "Alice Johnson",
      "review": "Could be better.",
      "rating": 3,
      "profile_image":
          "https://dummyimage.com/100x100/000/fff", // Dummy profile image
    },
  ];

  Widget _buildReviewsCard() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            XHeading(text: 'Reviews', fontSize: 16.0, color: Colors.black),
            SizedBox(height: 8.0),
            Column(
              children: dummyReviews.map((review) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      // Profile Picture
                      ClipOval(
                        child: Image.network(
                          review["profile_image"],
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error,
                                size:
                                    40); // Display an error icon if the image fails to load
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            XText(
                              text: review["user_name"],
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < review["rating"]
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.amber,
                                  size: 14,
                                );
                              }),
                            ),
                            XText(
                              text: review["review"],
                              fontSize: 12.0,
                              color: Colors.grey.shade600,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String amount, {Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 14.0,
            color: color ?? Colors.black,
          ),
        ),
      ],
    );
  }

    Widget _buildButtons() {
  return Padding(
    padding: const EdgeInsets.only(left: 1.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Track Order Button
        Expanded(
          child: XButton( 
            onPressed: () {
              // Handle Track Order action
              print('Track Order button pressed');
            },
            text: 'Track Order',
            buttonType: ButtonType.filled,
            color: Colors.black, // Set Track Order button background color to black
            textColor: Colors.white,
            borderRadius: 8.0,
            
            // Set vertical padding
          ),
        ),
        // Cancel Button
        Expanded(
          child: XButton(
            onPressed: () {
              // Handle Cancel action
              print('Cancel button pressed');
            },
            text: 'Cancel',
            buttonType: ButtonType.filled,
            color: Colors.red, // Set Cancel button background color to red
            textColor: Colors.white,
            borderRadius: 8.0,
          ),
        ),
      ],
    ),
  );
}
}
