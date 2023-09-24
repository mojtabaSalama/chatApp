import 'package:flutter/material.dart';

class AppName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "ChatApp",
      style: TextStyle(
          fontSize: 44,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          color: Colors.green[600]),
    );
  }
}
