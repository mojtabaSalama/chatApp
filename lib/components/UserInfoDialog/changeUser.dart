import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:chatapp/components/alertdialog/dialogButton.dart';
import 'package:chatapp/components/form_componenets/text_field.dart';
import 'package:http/http.dart' as http;
import 'package:chatapp/utilites/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeUser {
  TextEditingController nameController = TextEditingController();

  String error;
  String token;
  String newName;
  String name;
  int id;
  final BuildContext context;

  ChangeUser(this.context, this.id, this.token, this.newName);
  void editName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (nameController.text.isEmpty) {
        showSnackBar(context, "Name can't be empty");
      } else {
        var response = await http.post(
          Uri.parse(updateName),
          headers: {'Content-Type': 'application/json', "x-auth-token": token},
          body: jsonEncode({"id": id, "name": nameController.text}),
        );
        var decodedRespons = await jsonDecode(response.body);
        if (response.statusCode != 200) {
          showSnackBar(context, decodedRespons["msg"]);
        } else {
          name = nameController.text;
          await prefs.setString("userName", name);

          Navigator.pop(context);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void showSnackBar(context, msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      padding: EdgeInsets.all(10),
      backgroundColor: Colors.red,
      content: Text(msg),
    ));
  }

  void editUserBottomSheet(context) {
    try {
      nameController.text = name;
      showModalBottomSheet(
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                        "Enter your name :",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                    MyTextField(
                      controller: nameController,
                      obscureText: false,
                      hintText: "name",
                      error: error,
                    ),
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
                            onTab: editName,
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
}
