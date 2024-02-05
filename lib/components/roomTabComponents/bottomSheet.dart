import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:chatapp/components/alertdialog/dialogButton.dart';
import 'package:chatapp/components/form_componenets/text_field.dart';
import 'package:http/http.dart' as http;
import 'package:chatapp/utilites/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> sheet(
    TextEditingController controller,
    context,
    int id,
    String token,
    String type,
    void onTap,
    String headText,
    String buttonText) async {
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
                      headText,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  MyTextField(
                      controller: controller,
                      obscureText: false,
                      hintText: type == "room" ? "room name" : "name",
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
                          onTab: () => onTap,
                          buttonText: buttonText,
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
