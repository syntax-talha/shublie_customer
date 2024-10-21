import 'package:flutter/material.dart';
import 'package:shublie_customer/api/auth_service.dart'; // Import auth service
import 'package:shublie_customer/screens/change_password_screen.dart';
import 'package:shublie_customer/utils/colors.dart';
import 'package:shublie_customer/utils/configs.dart';
import 'profile_screen.dart'; // Import ProfileScreen
import 'package:shublie_customer/components/x_settings_card.dart';
import 'package:shublie_customer/components/x_text.dart'; // Import XText

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  // Use auth service to get user details dynamically
  final String profileName = '${auth.name}';
  final String profileEmail = auth.email.toString();
  final String profilePhone = auth.phoneNumber.toString();
  final String profileAddress = auth.id.toString();
  final String profileImageUrl = auth.profileImage.toString();

  @override
  Widget build(BuildContext context) {
    String fullImageUrl = profileImageUrl != null && profileImageUrl.isNotEmpty
        ? '${baseUrl}/$profileImageUrl'
        : '';
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        foregroundColor: Colors.white,
        backgroundColor: primaryColor, // Use primary color
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          color:
              Colors.white, // Set background color to white for the container
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Stack to add Edit Icon on top of profile image
              Stack(
                children: [
                  // Profile Image
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: fullImageUrl != null &&
                              fullImageUrl.isNotEmpty &&
                              fullImageUrl !=
                                  'assets/storage/images/default_profile.png'
                          ? NetworkImage(fullImageUrl) as ImageProvider<
                              Object> // Cast to ImageProvider<Object>
                          : AssetImage('') as ImageProvider<
                              Object>, // Cast to ImageProvider<Object>
                      backgroundColor: primaryColor,
                    ),
                  ),
                  // Edit Icon positioned at the top right
                  Positioned(
                    top: 70,
                    right: 100,
                    child: IconButton(
                      icon: Icon(Icons.camera_alt_rounded,
                          color: Color.fromARGB(255, 9, 5, 5)),
                      onPressed: () {
                        // Navigate to ProfileScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen()),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Divider(),

              // Profile Data (Dynamically loaded from auth)
              SettingsCard(
                title: 'Name',
                icon: Icons.person,
                iconColor: Colors.black, // Icon color set to black
                customValueWidget: XText(text: profileName), // Use XText for the value
                isSwitch: false,
              ),
              Divider(), // Separator Line
              SettingsCard(
                title: 'Email      ',
                icon: Icons.email,
                iconColor: Colors.black, // Icon color set to black
               
                customValueWidget: Flexible(
                  
                  child: XText(
          
                    text: profileEmail,
                    overflow: TextOverflow.ellipsis, // Handle overflow
                  ),
                ), // Use XText for the value
                isSwitch: false,
              ),
              Divider(), // Separator Line
              SettingsCard(
                title: 'Phone Number',
                icon: Icons.phone,
                iconColor: Colors.black, // Icon color set to black
                customValueWidget: XText(text: profilePhone), // Use XText for the value
                isSwitch: false,
              ),
              Divider(), // Separator Line
              SettingsCard(
                title: 'Address',
                icon: Icons.location_on,
                iconColor: Colors.black, // Icon color set to black
                customValueWidget: XText(text: profileAddress), // Use XText for the value
                isSwitch: false,
              ),

              // Other Settings
              Divider(), // Separator Line
              SettingsCard(
                title: 'Enable Notifications',
                icon: Icons.notifications,
                iconColor: Colors.black,
                isSwitch: true,
                switchValue: _notificationsEnabled,
                onSwitchChanged: (bool value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                  print('Notifications Enabled: $value');
                },
              ),
              Divider(), // Separator Line
              SettingsCard(
                title: 'Change Password',
                icon: Icons.lock,
                iconColor: Colors.black,
                isSwitch: false, // Not a switch option
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
                  );
                },
              ),

              Divider(), // Separator Line
              SettingsCard(
                title: 'Payment Settings',
                icon: Icons.payment,
                iconColor: Colors.black, // Icon color set to black
                onTap: () {
                  Navigator.pushNamed(context, '/payment-settings-screen');
                },
                isSwitch: false,
              ),
              Divider(), // Separator Line

              // New Wallet Balance Option
              SettingsCard(
                title: 'Wallet Balance',
                icon: Icons.account_balance_wallet,
                iconColor: Colors.black, // Icon color set to black
                onTap: () {
                  Navigator.pushNamed(context, '/wallet-balance-screen');
                },
                isSwitch: false,
              ),
              Divider(), // Separator Line

              SettingsCard(
                title: 'Help & Support',
                icon: Icons.help,
                iconColor: Colors.black, // Icon color set to black
                onTap: () {
                  Navigator.pushNamed(context, '/support-faq-screen');
                },
                isSwitch: false,
              ),
              Divider(), // Separator Line
              SettingsCard(
                title: 'Logout',
                icon: Icons.logout,
                iconColor: Colors.black, // Icon color set to black
                onTap: () {
                  auth.logout();
                  Navigator.pushNamed(context, '/login');
                },
                isSwitch: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
