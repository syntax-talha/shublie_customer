import 'package:flutter/material.dart';
import 'package:shublie_customer/components/x_text.dart'; // Import your XText widget

class SettingsCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Widget? customValueWidget;
  final bool isSwitch;
  final bool? switchValue;
  final ValueChanged<bool>? onSwitchChanged;
  final VoidCallback? onTap;
  final Color? activeColor; // New Parameter for switch fill color
  final Color? activeTrackColor; // New Parameter for switch track color
  final EdgeInsetsGeometry? padding; // Add padding parameter

  const SettingsCard({
    required this.title,
    required this.icon,
    this.iconColor = Colors.black,
    this.customValueWidget,
    this.isSwitch = false,
    this.switchValue,
    this.onSwitchChanged,
    this.onTap,
    this.activeColor,
    this.activeTrackColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor),
                SizedBox(width: 15),
                XText(text: title),
              ],
            ),
            if (isSwitch && switchValue != null)
              Container(
                height: 25, // Set a fixed height for the switch
                child: Switch(
                  value: switchValue!,
                  onChanged: onSwitchChanged,
                  activeColor: activeColor ?? Colors.black,
                  activeTrackColor: activeTrackColor ?? Colors.black12,
                ),
              ),
            if (!isSwitch && customValueWidget != null) customValueWidget!,
          ],
        ),
      ),
    );
  }
}
