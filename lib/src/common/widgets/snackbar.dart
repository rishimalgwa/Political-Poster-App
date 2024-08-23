import 'package:flutter/material.dart';

SnackBar successSnackbar(String message) {
  return SnackBar(
    content: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    ),
    duration: const Duration(seconds: 5),
    backgroundColor: Colors.green,
    behavior: SnackBarBehavior.floating,
    elevation: 2.0,
  );
}

SnackBar errorSnackbar(String message) {
  return SnackBar(
    content: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    ),
    duration: const Duration(seconds: 5),
    backgroundColor: Colors.red,
    behavior: SnackBarBehavior.floating,
    elevation: 2.0,
  );
}
