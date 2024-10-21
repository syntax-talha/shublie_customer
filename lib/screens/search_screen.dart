import 'package:flutter/material.dart';
import 'package:shublie_customer/components/search_card.dart'; // Ensure correct path
import 'package:shublie_customer/utils/colors.dart'; // Import your colors file

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isFilterVisible = false; // Initialize filter visibility to false

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: primaryColor, // Use primary color
        title: _buildSearchField(),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Conditionally show the filter Row based on _isFilterVisible
            _isFilterVisible
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Filtered by:',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          _buildFilterButton('Partners', () {
                            print("Filter by Partner selected");
                          }),
                          const SizedBox(width: 20.0),
                          _buildFilterButton('Categories', () {
                            print("Filter by Categories selected");
                          }),
                          const SizedBox(width: 20.0),
                          _buildFilterButton('Services', () {
                            print("Filter by Services selected");
                          }),
                        ],
                      ),
                    ],
                  )
                : const SizedBox.shrink(), // Hide the Row if _isFilterVisible is false

            const SizedBox(height: 8.0),

            // Call the UnifiedCard component here
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3, // Example number of cards
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: SearchCard(
                  data: {
                    'title': 'Test Service $index',
                    'description': 'This is a test description for service $index.',
                    'price': 100 + index * 10,
                  },  // Static Map data for testing
                  type: 'service',  // Example static type
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Search bar in AppBar with a filter icon
  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for services or vendors',
                prefixIcon: Icon(Icons.search, color: primaryColor),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.filter_list, color: primaryColor), // Filter icon
            onPressed: () {
              setState(() {
                _isFilterVisible = !_isFilterVisible; // Toggle filter visibility
              });
            },
          ),
        ],
      ),
    );
  }

  // Function to create a filter button with updated styles
  Widget _buildFilterButton(String label, VoidCallback onPressed) {
    return SizedBox(
      height: 25,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 237, 233, 233),
          foregroundColor: Colors.black,
          padding: EdgeInsets.symmetric(vertical: 0.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
