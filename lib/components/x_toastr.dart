import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class XToastr {
  static void show(
    BuildContext context,
    String message, 
    String toastType, // Accept type as string
    {Duration duration = const Duration(seconds: 2)} // Default duration
  ) {
    // Convert string to ToastificationType
    ToastificationType type;

    switch (toastType.toLowerCase()) {
      case 'success':
        type = ToastificationType.success;
        break;
      case 'error':
        type = ToastificationType.error;
        break;
      case 'info':
        type = ToastificationType.info;
        break;
      case 'warning':
      default:
        type = ToastificationType.warning; // Default to warning if unrecognized
    }

    // Show the toast
    toastification.show(
      context: context,
      type: type, // Use the converted enum
      style: ToastificationStyle.minimal,
      autoCloseDuration: duration,
      title: Text(message),
    );
  }
}
