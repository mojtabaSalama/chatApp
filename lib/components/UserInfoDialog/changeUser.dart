import 'dart:convert';

import 'package:chatapp/components/snackbar/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/components/alertdialog/dialogButton.dart';
import 'package:chatapp/components/form_componenets/text_field.dart';
import 'package:http/http.dart' as http;
import 'package:chatapp/utilites/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

void editName(TextEditingController nameController, BuildContext context,
    int id, String token) async {
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

        await prefs.remove("userName");
        await prefs.setString("userName", nameController.text);

        Navigator.pop(context);
      }
    }
  } catch (e) {
    print(e);
  }
}

void editUserBottomSheet(
  TextEditingController nameController,
  BuildContext context,
  int id,
  String token,
) async {
  try {
    showModalBottomSheet(
        // clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Enter the new name :",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  MyTextField(
                      controller: nameController,
                      obscureText: false,
                      hintText: "New Name",
                      error: ""),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        DialogButton(
                          onTab: () => {Navigator.pop(context)},
                          buttonText: "Cancel",
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        DialogButton(
                          onTab: () =>
                              editName(nameController, context, id, token),
                          buttonText: "OK",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  } catch (e) {
    print(e);
  }
}
