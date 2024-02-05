import 'dart:convert';

import 'package:chatapp/components/snackbar/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/components/alertdialog/dialogButton.dart';
import 'package:chatapp/components/form_componenets/text_field.dart';
import 'package:http/http.dart' as http;
import 'package:chatapp/utilites/config.dart';

// // class ChangePassword {
//   TextEditingController currentPasswordController = TextEditingController();
//   TextEditingController newPasswordController = TextEditingController();
//   late String error;
//   String token;
//   int id;
//   final BuildContext context;

//   ChangePassword(this.context, this.id, this.token);

void editPassword(
    TextEditingController currentPasswordController,
    TextEditingController newPasswordController,
    BuildContext context,
    int id,
    token) async {
  try {
    if (currentPasswordController.text.isEmpty ||
        newPasswordController.text.isEmpty) {
      // showSnackBar(context, "Empty field ,fill and try again", "error");
      Builder(builder: (BuildContext context) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          padding: EdgeInsets.all(10),
          backgroundColor: Colors.red,
          content: Text("Empty field ,fill and try again"),
        ));
        return Container();
      });
    } else {
      var response = await http.post(
        Uri.parse(updatePassword),
        headers: {'Content-Type': 'application/json', "x-auth-token": token},
        body: jsonEncode({
          "id": id,
          "currentPassword": currentPasswordController.text,
          "newPassword": newPasswordController.text
        }),
      );
      var decodedRespons = await jsonDecode(response.body);
      if (response.statusCode != 200) {
        showSnackBar(context, decodedRespons["msg"], "error");
      } else {
        showSnackBar(context, decodedRespons["msg"], "");
        Navigator.pop(context);

        newPasswordController.clear();
        currentPasswordController.clear();
      }
    }
  } catch (e) {
    print(e);
  }
}

void editPasswordBottomSheet(
    TextEditingController currentPasswordController,
    TextEditingController newPasswordController,
    BuildContext context,
    int id,
    String token) {
  showModalBottomSheet(
      // clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      // isScrollControlled: true,
      context: context,
      builder: (context) {
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
                    "Enter your current and new password :",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                MyTextField(
                  controller: currentPasswordController,
                  obscureText: true,
                  hintText: "Current Password",
                  error: "",
                ),
                MyTextField(
                    controller: newPasswordController,
                    obscureText: true,
                    hintText: "New Password",
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
                        onTab: () => editPassword(currentPasswordController,
                            newPasswordController, context, id, token),
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
}
// }
