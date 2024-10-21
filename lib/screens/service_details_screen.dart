import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shublie_customer/api/api_service.dart';
import 'package:shublie_customer/screens/order_information_page.dart';
import 'package:shublie_customer/utils/colors.dart';
import 'package:shublie_customer/components/background_screen.dart';
import 'package:shublie_customer/utils/configs.dart';
import 'package:shublie_customer/utils/images.dart';

class ServiceDetailScreen extends StatefulWidget {
  final String serviceId;
  final bool showOrderButton;

  const ServiceDetailScreen({
    required this.serviceId,
    this.showOrderButton = true,
  });

  @override
  _ServiceDetailScreenState createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  String? title;
  String? categoryId;
  String? description;
  String? returnDuration;
  String? price;
  String? address;
  String? onSpot;
  List<dynamic> images = [];
  Map<String, Map<String, List<String>>> availability = {
    "Monday": {"pickup_times": [], "dropoff_times": []},
    "Tuesday": {"pickup_times": [], "dropoff_times": []},
    "Wednesday": {"pickup_times": [], "dropoff_times": []},
    "Thursday": {"pickup_times": [], "dropoff_times": []},
    "Friday": {"pickup_times": [], "dropoff_times": []},
  };

  // Partner details
  String? partnerName;
  String? partnerEmail;
  String? partnerPhoneNumber;
  String? partnerAddress;
  String? partnerProfileImage;

  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchService();
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        _currentIndex = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _fetchService() async {
    try {
      final response = await api.fetchServiceById(widget.serviceId);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];
        setState(() {
          title = data['title'];
          categoryId = data['category_id'].toString();
          description = data['description'].toString();
          returnDuration = data['return_duration'].toString();
          price = data['price'].toString();
          address = jsonDecode(data['service_area'])["address_name"];
          onSpot = data['on_spot'].toString();
          images = jsonDecode(data['images']);

          if (data["availability"] is String) {
            Map<String, dynamic> availabilityJson =
                jsonDecode(data["availability"]);
            availability = availabilityJson.map((key, value) {
              return MapEntry(key, {
                "pickup_times": List<String>.from(value["pickup_times"]),
                "dropoff_times": List<String>.from(value["dropoff_times"]),
              });
            });
          } else if (data["availability"] is Map<String, dynamic>) {
            Map<String, dynamic> availabilityJson = data["availability"];
            availability = availabilityJson.map((key, value) {
              return MapEntry(key, {
                "pickup_times": List<String>.from(value["pickup_times"]),
                "dropoff_times": List<String>.from(value["dropoff_times"]),
              });
            });
          }

          // Partner details
          var provider = data['provider'];
          partnerName = '${provider['first_name']} ${provider['last_name']}';
          partnerEmail = provider['email'];
          partnerPhoneNumber = provider['phone_number'];
          partnerAddress = provider['address'].replaceAll(r'\"', '');
          partnerProfileImage = '${baseUrl}/${provider['profile_image']}';
        });
      } else {
        print('Failed to load service. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching service: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      backgroundImage: bgImage_12,
      overlayColor: Colors.white.withOpacity(0.1),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            title ?? '',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          backgroundColor: primaryColor,
          iconTheme: IconThemeData(
            color: Colors.white, // Set the back arrow color to white
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Slider with Thumbnails
                Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () =>
                                _showFullScreenImage(context, images[index]),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                '${baseUrl}${images[index]}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    // Thumbnails
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(images.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            _pageController.jumpToPage(index);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: _currentIndex == index
                                    ? Colors.blue
                                    : Colors.transparent,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                image:
                                    NetworkImage('${baseUrl}${images[index]}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Service Name
                Text(
                  title ?? '',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: 4),
                // Service Description
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title

                      SizedBox(height: 12),

                      // Description Header
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        description ?? 'No description available',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: 12),

                      // Location
                      Row(
                        children: [
                          Icon(Icons.location_on,
                              color: Colors.blueAccent, size: 24),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              address ?? 'No address provided',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),

                      // Return Duration
                      Row(
                        children: [
                          Icon(Icons.access_time,
                              color: Colors.orangeAccent, size: 24),
                          SizedBox(width: 8),
                          Text(
                            '$returnDuration hours',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),

                      // Service Price
                      Row(
                        children: [
                          Icon(Icons.price_change_rounded,
                              color: Colors.green[700], size: 24),
                          SizedBox(width: 8),
                          Text(
                            '\$$price',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.green[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),
                Divider(),
                // Partner Details
                Text(
                  'Provider ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: 10),
// Partner Name with Icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: partnerProfileImage != null
                          ? NetworkImage(partnerProfileImage!)
                          : null,
                      child: partnerProfileImage == null
                          ? Icon(Icons.person, color: Colors.white)
                          : null,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      // Use Expanded to allow the Text widget to take available space
                      child: Text(
                        partnerName ?? '',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        overflow: TextOverflow
                            .ellipsis, // Handle long names gracefully
                      ),
                    ),
                    SizedBox(width: 10), // Space between name and icons
                    IconButton(
                      icon: Icon(Icons.message, color: Colors.blue),
                      onPressed: () {
                        // Add your message action here
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.call, color: Colors.green),
                      onPressed: () {
                        // Add your call action here
                      },
                    ),
                  ],
                ),

                SizedBox(height: 10),
              ],
            ),
          ),
        ),
        bottomNavigationBar: widget.showOrderButton
            ? Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 8.0), // Reduced padding
                child: SizedBox(
                  width: double.infinity, // Full-width button
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderInformationPage(
                            serviceId: widget.serviceId,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor, // Set button color

                      padding: EdgeInsets.symmetric(
                          vertical: 13), // Adjust padding for height
                      textStyle: TextStyle(
                        fontSize: 14,
                      ),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Text('Book Now'),
                  ),
                ),
              )
            : SizedBox(),
      ),
    );
  }

  void _showFullScreenImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
