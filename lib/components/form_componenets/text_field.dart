import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final String error;

  MyTextField(
      {Key? key,
      required this.obscureText,
      required this.hintText,
      required this.controller,
      required this.error})
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
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          filled: true,
          errorText: error.isEmpty ? null : error,
          errorStyle: TextStyle(color: Colors.red, fontSize: 16),
        ),
        style: TextStyle(fontSize: 20.0),
        cursorColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
