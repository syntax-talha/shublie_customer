import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shublie_customer/api/api_service.dart';
import 'package:shublie_customer/components/x_text_field.dart';
import 'package:shublie_customer/screens/order_details_screen.dart';
import 'package:shublie_customer/utils/configs.dart';

class OrderInformationPage extends StatefulWidget {
  final String serviceId;

  const OrderInformationPage({
    Key? key,
    required this.serviceId,
  }) : super(key: key);

  @override
  _OrderInformationPageState createState() => _OrderInformationPageState();
}

class _OrderInformationPageState extends State<OrderInformationPage> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String title = '';
  String price = '';
  String address = '';
  late Map<String, dynamic> availability = {}; // Initialize with an empty map
  List<dynamic> images = [];
  List<String> pickupTimes = [];
  List<String> dropoffTimes = [];
  String? selectedPickupTime;
  String? selectedDropoffTime;
  int quantity = 1;
  String selectedLocation = '';
  String selectedDay = '';
  List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  List<String> _getPickupTimes() {
    if (availability.isNotEmpty && availability.containsKey(selectedDay)) {
      return List<String>.from(availability[selectedDay]['pickup_times']);
    }
    return [];
  }

  List<String> _getDropoffTimes() {
    if (availability.isNotEmpty && availability.containsKey(selectedDay)) {
      return List<String>.from(availability[selectedDay]['dropoff_times']);
    }
    return [];
  }

  List<String> getAvailableDays() {
    // Get the days from the availability map that have pickup or dropoff times
    List<String> availableDays = [];
    for (String day in daysOfWeek) {
      if (availability.containsKey(day) &&
          (availability[day]['pickup_times'].isNotEmpty ||
              availability[day]['dropoff_times'].isNotEmpty)) {
        availableDays.add(day);
      }
    }
    return availableDays;
  }

  void _updatePickupAndDropoffTimes() {
    setState(() {
      pickupTimes = _getPickupTimes();
      dropoffTimes = _getDropoffTimes();
      selectedPickupTime = null; // Reset selection
      selectedDropoffTime = null; // Reset selection
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchService();
  }

  Future<void> _fetchService() async {
    try {
      final response = await api.fetchServiceById(widget.serviceId);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];
        setState(() {
          title = data['title'];
          price = data['price'].toString();
          address = jsonDecode(data['service_area'])["address_name"];
          availability = jsonDecode(data['availability']);
          selectedDay = daysOfWeek[0]; // Default to the first day
          pickupTimes = _getPickupTimes();
          dropoffTimes = _getDropoffTimes();

          if (data['images'] != null && data['images'].isNotEmpty) {
            images = jsonDecode(data['images']);
          }
        });
      } else {
        print('Failed to load service. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching service: $e');
    }
  }

  double getSubtotal() {
    try {
      String cleanPrice = price.replaceAll(RegExp(r'[^0-9.]'), '');
      return double.parse(cleanPrice) * quantity;
    } catch (e) {
      print('Error parsing price: $e');
      return 0.0;
    }
  }

  void _navigateToBookingDetails() {
    final double subtotal = getSubtotal();
    final int qty = quantity;
    final double discount = 2.00;
    final double tax = 2.00;
    final double amount = subtotal - discount + tax;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderDetailsScreen(
          subtotal: subtotal,
          qty: qty,
          discount: discount,
          tax: tax,
          amount: amount,
        ),
      ),
    );
  }

  void _selectLocationFromMap() {
    setState(() {
      selectedLocation =
          "Selected location from map"; // Update with actual location
    });
  }

  void _useCurrentLocation() {
    setState(() {
      selectedLocation =
          "Current Location"; // Update with actual current location
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Order Information'),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            SizedBox(width: 3),
                            Expanded(
                              child: Text(
                                address,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Price: \$${price}',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 100.0,
                    height: 90.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: images.isNotEmpty
                            ? NetworkImage('$baseUrl${images[0]}')
                            : AssetImage('assets/default.jpg') as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            spreadRadius: 1),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          // New Address Section
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                XTextField(
                  controller: _addressController,
                  labelText: 'Enter Address',
                  icon: Icons.place,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: _selectLocationFromMap,
                      child: Text('Choose from Map'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                        foregroundColor: Color.fromRGBO(244, 67, 54, 1),
                        padding: EdgeInsets.only(left: 6),
                        elevation: 0,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _useCurrentLocation,
                      child: Text('Use Current Location'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Color.fromRGBO(244, 67, 54, 1),
                        padding: EdgeInsets.only(left: 2),
                        elevation: 0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'Selected Location: $selectedLocation',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
          ),
          // Existing Booking Details Section
          Container(
            margin: const EdgeInsets.symmetric(vertical: 2),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  XTextField(
                    controller:
                        _descriptionController, // Using description controller here
                    labelText: 'Enter Description',
                    icon: Icons.description,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Quantity', style: TextStyle(fontSize: 16)),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) quantity--;
                              });
                            },
                          ),
                          Text('$quantity', style: TextStyle(fontSize: 16)),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Day Selection Dropdown
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Availible Day', style: TextStyle(fontSize: 16)),
                      DropdownButton<String>(
                        value: selectedDay,
                        onChanged: (newValue) {
                          setState(() {
                            selectedDay = newValue!;
                            pickupTimes = _getPickupTimes();
                            dropoffTimes = _getDropoffTimes();
                            selectedPickupTime = null; // Reset selection
                            selectedDropoffTime = null; // Reset selection
                          });
                        },
                        items: getAvailableDays() // Use the filtered list here
                            .map<DropdownMenuItem<String>>((String day) {
                          return DropdownMenuItem<String>(
                            value: day,
                            child: Text(day),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Pickup Time Selection Dropdown
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Pickup Time', style: TextStyle(fontSize: 16)),
                      DropdownButton<String>(
                        value: selectedPickupTime,
                        onChanged: (newValue) {
                          setState(() {
                            selectedPickupTime = newValue!;
                          });
                        },
                        items: pickupTimes
                            .map<DropdownMenuItem<String>>((String time) {
                          return DropdownMenuItem<String>(
                            value: time,
                            child: Text(time),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Dropoff Time Selection Dropdown
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Dropoff Time', style: TextStyle(fontSize: 16)),
                      DropdownButton<String>(
                        value: selectedDropoffTime,
                        onChanged: (newValue) {
                          setState(() {
                            selectedDropoffTime = newValue!;
                          });
                        },
                        items: dropoffTimes
                            .map<DropdownMenuItem<String>>((String time) {
                          return DropdownMenuItem<String>(
                            value: time,
                            child: Text(time),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          SizedBox(height: 16),
          // Subtotal Section
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black26),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: [
                Text(
                  'Subtotal: \$${getSubtotal().toStringAsFixed(2)}',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                SizedBox(height: 4),
              ],
            ),
          ),
        ],
      ),
      // Bottom button that stays fixed
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.white, // Adjust background color if needed
        width: double.infinity, // Full width of the screen
        child: ElevatedButton(
          onPressed: _navigateToBookingDetails,
          child: Text('Continue'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              vertical: 12,
            ),
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }
}
