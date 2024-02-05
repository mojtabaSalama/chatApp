import 'dart:convert';

import 'package:chatapp/components/snackbar/snackBar.dart';
import 'package:chatapp/utilites/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void roomDatabase(TextEditingController roomNameController,
    BuildContext context, int id, String token, url) async {
  try {
    if (roomNameController.text.isEmpty) {
      print("empty");
      showSnackBar(context, "Name can't be empty", "error");
    } else {
      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json', "x-auth-token": token},
        body: jsonEncode({"id": id, "name": roomNameController.text}),
      );
      var decodedRespons = await jsonDecode(response.body);
      if (response.statusCode != 200) {
        showSnackBar(context, decodedRespons["msg"], "error");
      } else {
        Navigator.pop(context);
        showSnackBar(context, decodedRespons["msg"], "");
      }
    }
  } catch (e) {
    print(e);
  }
}
