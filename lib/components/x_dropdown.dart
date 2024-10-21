import 'package:flutter/material.dart';

class XDropdown<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String hint;

  const XDropdown({
    required this.items,
    required this.value,
    required this.onChanged,
    this.hint = 'Select an option',
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      value: value,
      onChanged: onChanged,
      hint: Text(hint),
      items: items,
    );
  }
}
