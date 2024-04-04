import 'dart:convert';

import 'package:chatapp/components/alertdialog/dialogButton.dart';
import 'package:chatapp/components/form_componenets/text_field.dart';
import 'package:chatapp/components/snackbar/snackBar.dart';
import 'package:chatapp/utilites/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void createNewRoom(TextEditingController roomNameController,
    BuildContext context, int id, String token) async {
  try {
    if (roomNameController.text.isEmpty) {
      print("empty");
      showSnackBar(context, "Name can't be empty", "error");
    } else {
      var response = await http.post(
        Uri.parse(createRoom),
        headers: {'Content-Type': 'application/json', "x-auth-token": token},
        body: jsonEncode({"id": id, "room_name": roomNameController.text}),
      );
      var decodedRespons = await jsonDecode(response.body);
      if (response.statusCode != 200) {
        showSnackBar(context, decodedRespons["msg"], "error");
      } else {
        showSnackBar(context, decodedRespons["msg"], "");
      }
    }
  } catch (e) {
    print(e);
  }
}

void createRoomBottomSheet(
  TextEditingController roomNameController,
  context,
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
                      "Create a room :",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  MyTextField(
                      controller: roomNameController,
                      obscureText: false,
                      hintText: "Room name",
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
                          onTab: () => createNewRoom(
                              roomNameController, context, id, token),
                          buttonText: "create",
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
