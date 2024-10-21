import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shublie_customer/api/api_service.dart';
import 'package:shublie_customer/api/auth_service.dart';
import 'package:shublie_customer/components/background_screen.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:shublie_customer/screens/booking_home_screen.dart';
import 'package:shublie_customer/screens/chat_list_screen.dart';
import 'package:shublie_customer/screens/notifications_screen.dart';
import 'package:shublie_customer/screens/search_screen.dart';
import 'package:shublie_customer/screens/service_details_screen.dart';
import 'package:shublie_customer/screens/settings_screen.dart';
import 'package:shublie_customer/utils/colors.dart';
import 'package:shublie_customer/utils/configs.dart';
import 'package:shublie_customer/utils/images.dart';
import 'package:shublie_customer/components/x_vendor_card.dart'; // Import the VendorCard
import 'package:shublie_customer/components/x_category_card.dart'; // Import the ServiceCard
import 'package:shublie_customer/components/x_service_card.dart'; // Import the CategoryCard

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController();
  int _selectedIndex = 0;
  String _selectedFilter =
      'all'; // Filter state: 'all', 'service', 'vendor', 'category'
  bool isLoading = true; // To manage loading state
  List<dynamic> services = [];
  List<dynamic> vendorProfiles = [];
  List<dynamic> categories = [];
  @override
  void initState() {
    super.initState();
    _fetchPartner(); // Fetch services when the widget is initialized
    _fetchServices();
    _fetchCategories(); // Fetch services when the widget is initialized
    _pageController = PageController();
  }

  Future<void> _fetchServices() async {
    try {
      final response = await api.fetchServices();
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        setState(() {
          services = jsonResponse['data']; // Access 'data' directly
          isLoading = false; // Stop loading
        });
      } else {
        print('Failed to load services. Status code: ${response.statusCode}');
        setState(() {
          isLoading = false; // Stop loading on error
        });
      }
    } catch (e) {
      print('Error fetching services: $e');
      setState(() {
        isLoading = false; // Stop loading on error
      });
    }
  }

  Future<void> _fetchPartner() async {
    try {
      final response = await api.fetchPartner();

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        setState(() {
          vendorProfiles = jsonResponse['data'];
          // Access 'data' directly
          isLoading = false; // Stop loading
        });
      } else {
        print('Failed to load partners. Status code: ${response.statusCode}');
        setState(() {
          isLoading = false; // Stop loading on error
        });
      }
    } catch (e) {
      print('Error fetching partners: $e');
      setState(() {
        isLoading = false; // Stop loading on error
      });
    }
  }

  Future<void> _fetchCategories() async {
    try {
      final response = await api.fetchCategories();

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        setState(() {
          categories = jsonResponse['data'];
          // Access 'data' directly
          isLoading = false; // Stop loading
        });
      } else {
        print('Failed to load categories. Status code: ${response.statusCode}');
        setState(() {
          isLoading = false; // Stop loading on error
        });
      }
    } catch (e) {
      print('Error fetching categories: $e');
      setState(() {
        isLoading = false; // Stop loading on error
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  void _applyFilter(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      backgroundImage: bgImage_12,
      overlayColor: Colors.white.withOpacity(0.1),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: [
            _buildHomeContent(), // Home screen content
            BookingHomeScreen(),
            ChatListScreen(),
            SettingsScreen(),
          ],
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  PreferredSizeWidget? _buildAppBar() {
    if (_selectedIndex != 0) return null;
    return AppBar(
      backgroundColor: primaryColor,
      elevation: 0,
      leading: CircleAvatar(
        backgroundImage: NetworkImage('$baseUrl/${auth.profileImage}'),
        backgroundColor: Colors.black,
      ),
      
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Welcome!', style: TextStyle(fontSize: 14, color: Colors.white)),
          Text(auth.name.toString(),
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchScreen()),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.notifications, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationsScreen()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildCustomerLocation(),
          if (_selectedFilter == 'all' || _selectedFilter == 'vendor')
            _buildVendors(),
          if (_selectedFilter == 'all' || _selectedFilter == 'category')
            _buildCategories(), // Category Cards
          // if (_selectedFilter == 'all' || _selectedFilter == 'service')
          _buildServices(), // Service Cards
        ],
      ),
    );
  }

  Widget _buildCustomerLocation() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          Icon(Icons.location_on, color: primaryColor),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              auth.address.toString().replaceAll(RegExp(r'[\"//\\]'), ''),
              overflow:
                  TextOverflow.ellipsis, // Ensure the text doesn't overflow
            ),
          ),
          Icon(Icons.arrow_drop_down),
          IconButton(
            padding: EdgeInsets.zero, // Remove padding around the icon
            icon: Image.asset(
              'assets/icons/ic_profile2.png', // Update with your file name
              color: _selectedFilter == 'vendor' ? primaryColor : Colors.black,
              width: 20.0, // Adjust as needed
              height: 20.0,
            ),
            onPressed: () => _applyFilter('vendor'),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            icon: Image.asset(
              'assets/icons/ic_category.png', // Update with your file name
              color:
                  _selectedFilter == 'category' ? primaryColor : Colors.black,
              width: 20.0,
              height: 20.0,
            ),
            onPressed: () => _applyFilter('category'),
          ),
        ],
      ),
    );
  }

  Widget _buildVendors() {
    return Container(
      height: 180, // Adjust the height for the horizontal scrolling area
      margin: EdgeInsets.symmetric(vertical: 5.0), // Decreased from 10.0
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: vendorProfiles.length, // Use the length of the vendor data
        itemBuilder: (context, index) {
          final vendorProfile = vendorProfiles[index]; // Get the current vendor

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: VendorCard(
              vendorName: vendorProfile['first_name'] +
                  ' ' +
                  vendorProfile['last_name'],
              vendorId: vendorProfile['id'].toString(),
              vendorImage: vendorProfile['profile_image'],
              vendorAddress: vendorProfile['address'], // Use the address
            ),
          );
        },
      ),
    );
  }

  Widget _buildServices() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: ListView.builder(
        physics:
            NeverScrollableScrollPhysics(), // Disable scrolling for the ListView
        shrinkWrap: true, // Let the ListView take the space it needs
        itemCount:
            (services.length / 2).ceil(), // Calculate the number of rows needed
        itemBuilder: (context, index) {
          int firstItemIndex = index * 2; // Index for the first item in the row
          int secondItemIndex =
              firstItemIndex + 1; // Index for the second item in the row

          return Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Align items evenly
              children: [
                // First Service Card
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Get the service ID from the first service
                      String serviceId =
                          services[firstItemIndex]['id'].toString();

                      // Navigate to the ServiceDetailsScreen with the service ID
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ServiceDetailScreen(
                              serviceId: serviceId), // Pass the service ID
                        ),
                      );
                    },
                    child: ServiceCard(
                      service: services[firstItemIndex],
                    ),
                  ),
                ),
                // Check if there's a second item before rendering it
                if (secondItemIndex < services.length)
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Retrieve the serviceId as a string
                        String serviceIdString =
                            services[firstItemIndex]['id'].toString();

                        // Convert the serviceId to an integer and increment it
                        int serviceId = int.parse(serviceIdString) + 1;
                        print(serviceId);
                        // Pass the incremented serviceId to the next screen as a string
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ServiceDetailScreen(
                              serviceId: serviceId.toString(),
                              showOrderButton:
                                  true, // Ensure this is set to true
                            ),
                          ),
                        );
                      },
                      child: ServiceCard(
                        service: services[secondItemIndex],
                      ),
                    ),
                  ),
                // If there's no second item, fill the remaining space
                if (secondItemIndex >= services.length)
                  const Expanded(
                    child: SizedBox(), // Empty widget to occupy space
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategories() {
    return Container(
      width: double.infinity, // Adjust the height for the slider area
      margin: EdgeInsets.symmetric(vertical: 1.0), // Decreased from 16.0
      child: CategorySlider(categories: categories), // Pass dynamic categories
    );
  }

  Widget _buildBottomNavigationBar() {
    return MotionTabBar(
      initialSelectedTab: 'Home',
      labels: ['Home', 'Bookings', 'Chats', 'Settings'],
      icons: [
        Icons.home,
        Icons.bookmark,
        Icons.chat,
        Icons.settings,
      ],
      onTabItemSelected: _onTabSelected,
    );
  }
}

class CategorySlider extends StatelessWidget {
  final List<dynamic> categories;

  const CategorySlider({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: EdgeInsets.symmetric(vertical: 2.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Horizontal scroll if needed
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: CategoryCard(
              categoryName: category['name'] ?? 'Unknown',
              categoryImage: category['image'] ?? '',
            ),
          );
        },
      ),
    );
  }
}
