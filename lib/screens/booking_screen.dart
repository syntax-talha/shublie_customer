import 'package:flutter/material.dart';
import 'package:shublie_customer/components/x_button.dart';
import 'package:shublie_customer/components/x_text_field.dart';
import 'package:shublie_customer/components/x_date_picker.dart';
import 'package:shublie_customer/components/x_time_picker.dart';
import 'package:shublie_customer/utils/colors.dart'; // Import your colors if needed

class BookingScreen extends StatelessWidget {
  final TextEditingController specialInstructionsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking'),
        backgroundColor: primaryColor, // Use primary color
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: XDatePicker(
                    initialDate: DateTime.now(),
                    onDateSelected: (selectedDate) async {
                      // Handle date selection
                    },
                  ),
                ),
                SizedBox(width: 16), // Space between date and time pickers
                Expanded(
                  child: XTimePicker(
                    initialTime: TimeOfDay.now(),
                    onTimeSelected: (selectedTime) async {
                      // Handle time selection
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Map (Placeholder for Map widget)
            Container(
              height: 200,
              color: Colors.grey[300],
              child: Center(child: Text('Map Placeholder')),
            ),
            SizedBox(height: 16),

            // Special Instructions TextField
            XTextField(
              controller: specialInstructionsController,
              labelText: 'Special Instructions',
              icon: Icons.note,
              isPassword: false,
              keyboardType: TextInputType.text,
              iconColor: primaryColor, // Use primary color
            ),
            SizedBox(height: 16),

            // Proceed to Payment Button
            XButton(
              text: 'Proceed to Payment',
              onPressed: () {
                // Handle payment action
              },
              buttonType: ButtonType.elevated,
              color: primaryColor, // Use primary color
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
