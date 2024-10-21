import 'package:flutter/material.dart';
import 'package:shublie_customer/components/x_button.dart';
import 'package:shublie_customer/components/x_text_field.dart';
import 'package:shublie_customer/components/x_heading.dart';
import 'package:shublie_customer/components/x_text.dart';
import 'package:shublie_customer/utils/colors.dart';
import 'package:shublie_customer/components/x_settings_card.dart'; // Import your SettingsCard component

class PaymentSettingsScreen extends StatefulWidget {
  @override
  _PaymentSettingsScreenState createState() => _PaymentSettingsScreenState();
}

class _PaymentSettingsScreenState extends State<PaymentSettingsScreen> {
  final TextEditingController billingAddressController = TextEditingController(text: 'Jl.Kaliurang 12, Magelang');
  final List<String> paymentMethods = ['Visa **** **** 1234', 'MasterCard **** **** 5678'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: XHeading(
          text: 'Payment Settings',
          fontSize: 20.0,
          color: Colors.white,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Payment Methods'),
            Divider(),
            _buildPaymentMethodsList(),
            SizedBox(height: 20),
            _buildAddPaymentMethodButton(),
            SizedBox(height: 20),
            _buildSectionTitle('Default Payment Method'),
            Divider(),
            _buildDefaultPaymentMethod(),
            SizedBox(height: 20),
            _buildSectionTitle('Billing Information'),
            Divider(),
            _buildBillingInfo(),
            SizedBox(height: 20),
            _buildSectionTitle('Promotions & Vouchers'),
            Divider(),
            _buildPromotionsVouchers(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return XHeading(
      text: title,
      fontSize: 18,
      color: primaryColor,
    );
  }

  Widget _buildPaymentMethodsList() {
    return Column(
      children: paymentMethods.map((method) {
        return Column(
          children: [
            SettingsCard(
              title: method,
              icon: Icons.credit_card,
              iconColor: primaryColor, // Pass the icon color
              onTap: () {
                _editPaymentMethod(method);
              },
              customValueWidget: Icon(Icons.edit, color: primaryColor), // Custom edit icon
            ),
            Divider(), // Add divider after each payment method
          ],
        );
      }).toList(),
    );
  }

  void _editPaymentMethod(String method) {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController cardNumberController = TextEditingController(text: method);
        return AlertDialog(
          title: XHeading(text: 'Edit Payment Method'),
          content: SingleChildScrollView( // Ensure scrollability
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                XTextField(
                  controller: cardNumberController,
                  labelText: 'Card Number',
                  isPassword: false,
                ),
                SizedBox(height: 20),
                XButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'Save',
                  buttonType: ButtonType.filled,
                  color: primaryColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddPaymentMethodButton() {
    return XButton(
      onPressed: _addPaymentMethod,
      text: 'Add Payment Method',
      buttonType: ButtonType.filled,
      icon: Icons.add,
      color: primaryColor,
    );
  }

  void _addPaymentMethod() {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController cardNumberController = TextEditingController();
        final TextEditingController cardHolderNameController = TextEditingController();
        final TextEditingController expiryDateController = TextEditingController();
        final TextEditingController cvvController = TextEditingController();

        return AlertDialog(
          title: XHeading(text: 'Add Payment Method'),
          content: SingleChildScrollView( // Ensure scrollability
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                XTextField(
                  controller: cardNumberController,
                  labelText: 'Card Number',
                  isPassword: false,
                ),
                XTextField(
                  controller: cardHolderNameController,
                  labelText: 'Card Holder Name',
                  isPassword: false,
                ),
                XTextField(
                  controller: expiryDateController,
                  labelText: 'Expiry Date',
                  isPassword: false,
                ),
                XTextField(
                  controller: cvvController,
                  labelText: 'CVV',
                  isPassword: true,
                ),
                SizedBox(height: 20),
                XButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'Add',
                  buttonType: ButtonType.filled,
                  color: primaryColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDefaultPaymentMethod() {
    return Column(
      children: [
        SettingsCard(
          title: 'Visa **** **** 1234',
          icon: Icons.check_circle,
          iconColor: Colors.green, // Pass the green color for the check icon
          onTap: _editDefaultPaymentMethod,
        ),
        Divider(), // Add divider after default payment method
      ],
    );
  }

  void _editDefaultPaymentMethod() {
    // Functionality to change default payment method
  }

  Widget _buildBillingInfo() {
    return Column(
      children: [
        SettingsCard(
          title: 'Jl.Kaliurang 12, Magelang',
          icon: Icons.location_on,
          iconColor: primaryColor,
          onTap: _editBillingInfo,
          customValueWidget: Icon(Icons.edit, color: primaryColor),
        ),
        Divider(), // Add divider after billing info
      ],
    );
  }

  void _editBillingInfo() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: XHeading(text: 'Edit Billing Information'),
          content: SingleChildScrollView( // Ensure scrollability
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                XTextField(
                  controller: billingAddressController,
                  labelText: 'Billing Address',
                ),
                SizedBox(height: 20),
                XButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'Save',
                  buttonType: ButtonType.filled,
                  color: primaryColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPromotionsVouchers() {
    return SettingsCard(
      title: 'Apply Promotional Code',
      icon: Icons.card_giftcard,
      iconColor: primaryColor,
      onTap: _applyPromoCode,
      customValueWidget: Icon(Icons.arrow_forward, color: primaryColor),
    );
  }

  void _applyPromoCode() {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController promoCodeController = TextEditingController();

        return AlertDialog(
          title: XHeading(text: 'Apply Promotional Code'),
          content: SingleChildScrollView( // Ensure scrollability
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                XTextField(
                  controller: promoCodeController,
                  labelText: 'Promo Code',
                ),
                SizedBox(height: 20),
                XButton(
                  onPressed: () {
                    print('Promo code applied: ${promoCodeController.text}');
                    Navigator.pop(context);
                  },
                  text: 'Apply',
                  buttonType: ButtonType.filled,
                  color: primaryColor,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: XText(text: 'Cancel', color: Colors.red),
            ),
          ],
        );
      },
    );
  }
}
