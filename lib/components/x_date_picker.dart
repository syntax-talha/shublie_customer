import 'package:flutter/material.dart';

class XDatePicker extends StatelessWidget {
  final DateTime initialDate;
  final Future<void> Function(DateTime date) onDateSelected;

  const XDatePicker({
    required this.initialDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (selectedDate != null) {
          await onDateSelected(selectedDate);
        }
      },
      child: Text('Pick a date'),
    );
  }
}
