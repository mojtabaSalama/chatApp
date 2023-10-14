import 'dart:convert';

import 'package:chatapp/components/form_componenets/app_name.dart';
import 'package:chatapp/components/form_componenets/form_button.dart';
import 'package:chatapp/components/form_componenets/text_field.dart';
import 'package:chatapp/pages/chats.dart';
import 'package:chatapp/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:chatapp/utilites/config.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController nameContrller = TextEditingController();
  final TextEditingController passwordContrller = TextEditingController();
  String error;
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void loginUser() async {
    try {
      if (nameContrller.text.isNotEmpty || passwordContrller.text.isNotEmpty) {
        var loginBody = {
          "name": nameContrller.text,
          "password": passwordContrller.text
        };
        var response = await http.post(
          Uri.parse(login),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(loginBody),
        );
        // print(response.body);
        var decodedRespons = await jsonDecode(response.body);

        // print(decodedRespons["token"]);
        var status = response.statusCode;
        if (status != 200) {
          setState(() {
            error = decodedRespons["msg"];
          });
        } else {
          var myToken = decodedRespons["token"];
          var user = decodedRespons["user"];
          var userId = user["id"];
          var userName = user["name"];
          var profilePic = user["profilePicture"];
          print(profilePic);
          await prefs.setString("token", myToken);
          await prefs.setInt("userId", userId);
          await prefs.setString("userName", userName);

          // print(response.body);

          await prefs.setString("DBprofilePic", profilePic);

          Chats(
            token: myToken,
          );
          // Loading(
          //   token: myToken,
          // );
          await Navigator.pushReplacementNamed(context, '/chats');
        }
      } else {
        setState(() {
          error = "empty field";
        });
      }
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
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
                  Text(
                    "Your friends are waiting ! ",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold),
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
                    error: error != null ? "" : error,
                    controller: nameContrller,
                  ),
                  MyTextField(
                    obscureText: true,
                    hintText: "passowrd",
                    error: error,
                    controller: passwordContrller,
                  ),
                  SizedBox(
                    height: 60,
                  ),

                  MyButton(
                    onTab: () {
                      // Navigator.pushNamed(context, '/chats');
                      loginUser();
                    },
                    buttonText: "Login ",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "don't have an account?",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2,
                            color: Colors.grey[600]),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text(
                            "Register",
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
