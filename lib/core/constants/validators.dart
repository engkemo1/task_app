import 'package:flutter/material.dart';


class Validators {


  static String? validate(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return "Please enter your required filed";
    }
    return null;
  }

  static String? validatePassword(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return "Please enter a Phone Number";
    }
    if (!RegExp(r'^\d{9}$').hasMatch(value)) {
      return "Please enter a valid phone number";
    }
    return null;
  }
}
