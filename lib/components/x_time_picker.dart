import 'package:flutter/material.dart';

class XTimePicker extends StatelessWidget {
  final TimeOfDay initialTime;
  final Future<void> Function(TimeOfDay time) onTimeSelected;

  const XTimePicker({
    required this.initialTime,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final selectedTime = await showTimePicker(
          context: context,
          initialTime: initialTime,
        );

        if (selectedTime != null) {
          await onTimeSelected(selectedTime);
        }
      },
      child: Text('Pick a time'),
    );
  }
}
