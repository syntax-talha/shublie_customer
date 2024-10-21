import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shublie_customer/components/x_toastr.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter/material.dart';

void handleFieldErrors(
    Map<String, String?> fieldErrors, Map<String, dynamic> errorResponse) {
  // Reset field errors
  fieldErrors.updateAll((key, value) => null);

  // Check if "errors" exists in the response
  if (errorResponse.containsKey("errors")) {
    // Map errors from response to fields
    errorResponse["errors"].forEach((field, errors) {
      // If the field is already present, update it; if not, add it
      if (fieldErrors.containsKey(field)) {
        fieldErrors[field] = errors.join(", ");
      } else {
        fieldErrors[field] = errors.join(", "); // Add new field with errors
      }
    });
  }
}

void unexpectedResponse(response, context) {
  if (response.statusCode == 401) {
    var message = json.decode(response.body)["message"];
    XToastr.show(context, message, "error");
  } else if (response.statusCode == 400) {
    var message = json.decode(response.body)["message"];
    XToastr.show(context, message, "error");
  } else {
    XToastr.show(context, 'An error occurred: $response', "error");
  }
}

void unexpectedError(context, dynamic e) {
  XToastr.show(context, 'An error occurred: $e', "error");
}

String formatTimestamp(String timestamp) {
  try {
    // Parse the timestamp string to DateTime
    DateTime dateTime = DateTime.parse(timestamp);

    // Format the DateTime to a readable time (like WhatsApp)
    // For example: 3:30 PM or just 'Today 3:30 PM' depending on the date
    DateFormat timeFormat = DateFormat.jm(); // e.g., 3:30 PM
    DateFormat dateFormat = DateFormat.yMMMd(); // e.g., Sep 26, 2024

    // Get today's date
    DateTime now = DateTime.now();

    // Compare dates
    if (now.year == dateTime.year &&
        now.month == dateTime.month &&
        now.day == dateTime.day) {
      // If the date is today
      return '${timeFormat.format(dateTime)}';
    } else if (now.year == dateTime.year) {
      // If the date is this year
      return '${dateFormat.format(dateTime)} at ${timeFormat.format(dateTime)}';
    } else {
      // If the date is from a different year
      return dateFormat.format(dateTime);
    }
  } catch (e) {
    // Return a default message or an error message if parsing fails
    return 'Invalid date';
  }
}
