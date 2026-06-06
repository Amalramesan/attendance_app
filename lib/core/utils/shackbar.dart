import 'package:flutter/material.dart';

class SnackbarUtils {
  SnackbarUtils._();

  static void showError(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}