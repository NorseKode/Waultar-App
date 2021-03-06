import 'package:flutter/material.dart';

class SnackBarCustom {
  static useSnackbarOfContext(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF272837),
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
