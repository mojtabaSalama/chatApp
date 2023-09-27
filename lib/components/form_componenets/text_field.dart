import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final String error;

  MyTextField(
      {Key key, this.obscureText, this.hintText, this.controller, this.error})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            hintStyle: TextStyle(fontSize: 20.0),
            hintText: hintText,
            border: OutlineInputBorder(),
            hoverColor: Colors.green,
            filled: true,
            errorText: error == null ? null : error,
            errorStyle: TextStyle(color: Colors.red, fontSize: 16)),
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}
