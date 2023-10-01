import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String content, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        showCloseIcon: false,
        backgroundColor: color,
        duration: const Duration(seconds: 3),
      )
  );
}