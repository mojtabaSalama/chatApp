import 'dart:convert';

import 'package:chatapp/components/form_componenets/app_name.dart';
import 'package:chatapp/components/form_componenets/form_button.dart';
import 'package:chatapp/components/form_componenets/text_field.dart';
import 'package:chatapp/utilites/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController nameContrller = TextEditingController();
  final TextEditingController passwordContrller = TextEditingController();

  late String error = "";

  void registerUser() async {
    try {
      if (nameContrller.text.isNotEmpty || passwordContrller.text.isNotEmpty) {
        setState(() {
          // error = null;
        });
        var registerBody = {
          "name": nameContrller.text,
          "password": passwordContrller.text
        };
        var response = await http.post(
          Uri.parse(register),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(registerBody),
        );
        var decodedRespons = jsonDecode(response.body);
        var status = response.statusCode;
        if (status != 200) {
          setState(() {
            error = decodedRespons["msg"];
          });
        } else {
          Navigator.pushNamed(context, '/login');
        }
      } else {
        setState(() {
          error = "empty field";
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                  ),

                  AppName(),

                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text(
                      "Join your freinds now! ",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  // Text(
                  //   "Chat indvidually or create a room \n \t \t \t \t and have fun together ! ",
                  //   style: TextStyle(
                  //     fontSize: 20,
                  //     letterSpacing: 1,
                  //     color: Colors.grey[600],
                  //   ),
                  // ),
                  MyTextField(
                    obscureText: false,
                    hintText: "Name",
                    controller: nameContrller,
                    error: error,
                  ),
                  MyTextField(
                    obscureText: true,
                    hintText: "Passowrd",
                    controller: passwordContrller,
                    error: error,
                  ),

                  SizedBox(
                    height: 60,
                  ),

                  MyButton(
                    onTab: () {
                      registerUser();

                      // Navigator.pushNamed(context, '/chats');
                    },
                    buttonText: "Register ",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2,
                            color: Colors.grey[600]),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.green[600]),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ]))
        ],
      ),
    );
  }
}
