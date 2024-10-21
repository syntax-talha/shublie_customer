import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shublie_customer/components/x_button.dart'; // Update with the correct path to your XButton component
import 'package:shublie_customer/components/x_text_field.dart'; // Update with the correct path to your XTextField component
import 'package:shublie_customer/utils/colors.dart'; // Ensure correct path to your primary color

class ReviewRatingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leave a Review'),
        centerTitle: true,
        backgroundColor: primaryColor, // Use the primary color
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Rating Widget
            Text(
              'How would you rate your experience?',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: primaryColor, // Use the primary color for the text
              ),
            ),
            SizedBox(height: 8.0),
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print('Rating: $rating');
              },
            ),
            SizedBox(height: 24.0),

            // Review Text Field
            Text(
              'Tell Us What You Think',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: primaryColor, // Use the primary color for the text
              ),
            ),
            SizedBox(height: 8.0),
            XTextField(
              controller: TextEditingController(),
              labelText: 'Your comments here...',
              icon: Icons.comment, // Added required icon parameter
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 24.0),

            // Submit Button
            XButton(
              text: 'Submit Review',
              onPressed: () {
                print('Review submitted');
              },
              buttonType: ButtonType.elevated,
              color: primaryColor, // Use the primary color for the button
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
