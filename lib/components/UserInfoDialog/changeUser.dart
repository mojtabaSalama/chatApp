import 'dart:convert';

import 'package:chatapp/components/snackbar/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/components/alertdialog/dialogButton.dart';
import 'package:chatapp/components/form_componenets/text_field.dart';
import 'package:http/http.dart' as http;
import 'package:chatapp/utilites/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

void editName(TextEditingController nameController, BuildContext context,
    int id, String token, String name) async {
  print("object");
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (nameController.text.isEmpty) {
      showSnackBar(context, "Name can't be empty", "error");
    } else {
      var response = await http.post(
        Uri.parse(updateName),
        headers: {'Content-Type': 'application/json', "x-auth-token": token},
        body: jsonEncode({"id": id, "name": nameController.text}),
      );
      var decodedRespons = await jsonDecode(response.body);
      if (response.statusCode != 200) {
        showSnackBar(context, decodedRespons["msg"], "error");
      } else {
        showSnackBar(context, decodedRespons["msg"], "");

        Navigator.pop(context);
      }
    }
  } catch (e) {
    print(e);
  }
}
