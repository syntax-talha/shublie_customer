import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shublie_customer/api/api_service.dart';
import 'package:shublie_customer/screens/booking_detail_screen.dart';
import 'package:shublie_customer/utils/colors.dart';
import 'package:shublie_customer/components/x_text.dart';
import 'package:shublie_customer/components/x_heading.dart';
import 'package:shublie_customer/utils/configs.dart';

class BookingHomeScreen extends StatefulWidget {
  @override
  _BookingHomeScreenState createState() => _BookingHomeScreenState();
}

class _BookingHomeScreenState extends State<BookingHomeScreen> {
  List<dynamic> bookings = [];
  bool isLoading = true;
  bool isGridView = false; // Track the view mode

  @override
  void initState() {
    super.initState();
    _fetchBookings();
  }

  Future<void> _fetchBookings() async {
    try {
      final response = await api.fetchBookings();
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        setState(() {
          bookings = jsonResponse['data'];
          isLoading = false;
        });
      } else {
        print('Failed to load bookings. Status code: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching bookings: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      case 'Processing':
        return Colors.orange;
      case 'Pending':
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: XHeading(
          text: 'Bookings',
          color: Colors.white,
        ),
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.list : Icons.grid_view),
            color: Colors.white,
            onPressed: () {
              setState(() {
                isGridView = !isGridView; // Toggle view
              });
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : isGridView // Render Grid or List based on the view mode
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns in grid view
                    childAspectRatio: 0.9, // Adjust the height/width ratio
                  ),
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    final booking = bookings[index];
                    return _buildGridBookingCard(context, booking);
                  },
                )
              : ListView.builder(
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    final booking = bookings[index];
                    return _buildListBookingCard(context, booking);
                  },
                ),
    );
  }

  Widget _buildListBookingCard(BuildContext context, dynamic booking) {
    List<dynamic> images = [];
    if (booking['service']?['images'] != null &&
        booking['service']['images'].isNotEmpty) {
      images = jsonDecode(booking['service']['images']);
    }

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingDetailScreen(booking: booking),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 3,
        child: Row(
          children: [
            // Image Section
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    '${baseUrl}${images.isNotEmpty ? images[0] : ''}',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Text Section
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 1.0),
                          decoration: BoxDecoration(
                            color:
                                _getStatusColor(booking["status"] ?? 'Unknown')
                                    .withOpacity(0.2),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: XText(
                            text: booking["status"] ?? 'Unknown',
                            fontSize: 9.0,
                            color:
                                _getStatusColor(booking["status"] ?? 'Unknown'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.0),
                    XHeading(
                      text: booking["service"]?["title"] ?? 'No description',
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                    SizedBox(height: 4.0),
                    XText(
                      text: '\$${booking["amount"] ?? '0.00'}',
                      fontSize: 14.0,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridBookingCard(BuildContext context, dynamic booking) {
    List<dynamic> images = [];
    if (booking['service']?['images'] != null &&
        booking['service']['images'].isNotEmpty) {
      images = jsonDecode(booking['service']['images']);
    }

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingDetailScreen(booking: booking),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Container(
              height: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                image: DecorationImage(
                  image: NetworkImage(
                    '${baseUrl}${images.isNotEmpty ? images[0] : ''}',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Text Section
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 1.0),
                        decoration: BoxDecoration(
                          color: _getStatusColor(booking["status"] ?? 'Unknown')
                              .withOpacity(0.2),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: XText(
                          text: booking["status"] ?? 'Unknown',
                          fontSize: 9.0,
                          color:
                              _getStatusColor(booking["status"] ?? 'Unknown'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  XHeading(
                    text: booking["service"]?["title"] ?? 'No description',
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  SizedBox(height: 4.0),
                  XText(
                    text: '\$${booking["amount"] ?? '0.00'}',
                    fontSize: 14.0,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
