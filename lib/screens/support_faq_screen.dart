import 'package:flutter/material.dart';
import 'package:shublie_customer/components/x_text.dart';
import 'package:shublie_customer/components/x_heading.dart';
import 'package:shublie_customer/utils/colors.dart'; // Ensure correct path to colors file

class SupportFAQScreen extends StatefulWidget {
  @override
  _SupportFAQScreenState createState() => _SupportFAQScreenState();
}

class _SupportFAQScreenState extends State<SupportFAQScreen> {
  // List of FAQs
  List<FAQ> _faqList = [
    FAQ(question: 'How to use the app?', answer: 'Here is how you can use the app...'),
    FAQ(question: 'How to reset my password?', answer: 'To reset your password...'),
    FAQ(question: 'How to contact support?', answer: 'You can contact support by...'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: XHeading(
          text: 'Support & FAQs',
          color: Colors.white,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Set the back arrow color to white
          onPressed: () {
            Navigator.pop(context); // Pop the current screen from the navigation stack
          },
        ),
      ),
      body: Column(
        children: [
          // FAQs Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.zero, // No rounded corners
              ),
              child: _buildFAQs(),
            ),
          ),
          SizedBox(height: 20),
          // Contact Us Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.zero, // No rounded corners
              ),
              child: _buildContactUs(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQs() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _faqList[index].isExpanded = !isExpanded;
        });
      },
      children: _faqList.map<ExpansionPanel>((FAQ faq) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: XText(text: faq.question),
            );
          },
          body: ListTile(
            title: XText(text: faq.answer),
          ),
          isExpanded: faq.isExpanded,
        );
      }).toList(),
    );
  }

  Widget _buildContactUs() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          XHeading(
            text: 'Contact Us',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.phone, color: primaryColor), // Use primary color for the icon
              SizedBox(width: 10),
              XText(
                text: 'Phone: +123 456 789',
                fontSize: 16,
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.email, color: primaryColor), // Use primary color for the icon
              SizedBox(width: 10),
              XText(
                text: 'Email: support@example.com',
                fontSize: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Define FAQ class for the ExpansionPanelList
class FAQ {
  String question;
  String answer;
  bool isExpanded;

  FAQ({required this.question, required this.answer, this.isExpanded = false});
}
