import 'package:flutter/material.dart';
import 'package:shublie_customer/components/x_avatar.dart';
import 'package:shublie_customer/components/x_button.dart';
import 'package:shublie_customer/components/x_checkbox.dart';
import 'package:shublie_customer/components/x_date_picker.dart';
import 'package:shublie_customer/components/x_dialog.dart';
import 'package:shublie_customer/components/x_dropdown.dart';
import 'package:shublie_customer/components/x_icon_button.dart';
import 'package:shublie_customer/components/x_image.dart';
import 'package:shublie_customer/components/x_progress_indicator.dart';
import 'package:shublie_customer/components/x_radio_button.dart';
import 'package:shublie_customer/components/x_toastr.dart';
import 'package:shublie_customer/components/x_switch.dart';
import 'package:shublie_customer/components/x_text_field.dart';
import 'package:shublie_customer/components/x_time_picker.dart';
import 'package:shublie_customer/screens/x_list_tile.dart';
import 'package:shublie_customer/screens/x_stepper.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _switchValue = false;
  bool _checkboxValue = false;
  String? _dropdownValue = 'Option 1';
  String _radioValue = 'Option 1';
  int _currentStep = 0;

  void _onStepContinue(int step) {
    setState(() {
      _currentStep = step;
    });
  }

  void _onStepTapped(int step) {
    setState(() {
      _currentStep = step;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Email Field
            XTextField(
              controller: _emailController,
              labelText: 'Email',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),

            XButton(
              text: 'Test',
              onPressed: () {},
            ),

            XIconButton(
              icon: Icons.thumb_up,
              onPressed: () {
                print('Thumb Up Icon Button Pressed');
              },
              color: Colors.blue,
              size: 30.0,
            ),
            XSwitch(
              value: _switchValue,
              onChanged: (value) {
                setState(() {
                  _switchValue = value;
                });
              },
            ),
            XCheckbox(
              value: _checkboxValue,
              onChanged: (value) {
                setState(() {
                  _checkboxValue = value!;
                });
              },
            ),
            XRadioButton<String>(
              value: 'Option 1',
              groupValue: _radioValue,
              onChanged: (value) {
                setState(() {
                  _radioValue = value!;
                });
              },
            ),
            XDropdown<String>(
              value: _dropdownValue,
              onChanged: (value) {
                setState(() {
                  _dropdownValue = value;
                });
              },
              items: [
                DropdownMenuItem(value: 'Option 1', child: Text('Option 1')),
                DropdownMenuItem(value: 'Option 2', child: Text('Option 2')),
              ],
            ),
            XProgressIndicator(size: 50.0),

            XDatePicker(
              initialDate: DateTime.now(),
              onDateSelected: (date) async {
                print('Selected date: $date');
              },
            ),
            XTimePicker(
              initialTime: TimeOfDay.now(),
              onTimeSelected: (time) async {
                print('Selected time: $time');
              },
            ),
            ElevatedButton(
              onPressed: () {
                XToastr.show(context, "Hello Toastr", "success");
              },
              child: Text('Show Toastr'),
            ),
            ElevatedButton(
              onPressed: () {
                XDialog.show(
                  context,
                  title: 'Dialog Title',
                  content: 'This is the content of the dialog.',
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Add your action here
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
              child: Text('Show Dialog'),
            ),

            XStepper(
              steps: [
                Step(
                  title: Text('Step 1'),
                  content: Text('Content for Step 1'),
                  isActive: _currentStep >= 0,
                ),
                Step(
                  title: Text('Step 2'),
                  content: Text('Content for Step 2'),
                  isActive: _currentStep >= 1,
                ),
                Step(
                  title: Text('Step 3'),
                  content: Text('Content for Step 3'),
                  isActive: _currentStep >= 2,
                ),
              ],
              currentStep: _currentStep,
              onStepContinue: _onStepContinue,
              onStepTapped: _onStepTapped,
              onStepCancel: () {
                if (_currentStep > 0) {
                  setState(() {
                    _currentStep -= 1;
                  });
                }
              },
            ),

            // XListTile
            XListTile(
              title: 'List Tile Title',
              subtitle: 'List Tile Subtitle',
              leadingIcon: Icons.list,
              trailingIcon: Icons.arrow_forward,
              onTap: () {
                print('List Tile Tapped');
              },
            ),
            XListTile(
              title: 'List Tile Title',
              subtitle: 'List Tile Subtitle',
              leadingIcon: Icons.list,
              trailingIcon: Icons.arrow_forward,
              onTap: () {
                print('List Tile Tapped');
              },
            ),
            XListTile(
              title: 'Account',
              subtitle: 'List of 20 users',
              leadingIcon: Icons.hail_outlined,
              trailingIcon: Icons.arrow_forward,
              onTap: () {
                print('List Tile Tapped');
              },
            ),
          ],
        ),
      ),
    );
  }
}
