import 'package:flutter/material.dart';
import '../colors.dart';

class CustomSnackbar {
  static void show(BuildContext context, String message) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 1),
      content: Text(
        message,
        style: TextStyle(color: FitnessColor.colorEdit),
      ),
      backgroundColor: FitnessColor.colorTextThird,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
