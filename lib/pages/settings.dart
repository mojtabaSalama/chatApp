import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(
          "Settings",
          style: TextStyle(
            fontSize: 28.0,
          ),
        ),
      ),
    );
  }
}
