import 'package:chatapp/components/form_componenets/app_name.dart';
import 'package:chatapp/components/form_componenets/form_button.dart';
import 'package:chatapp/components/form_componenets/text_field.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final userNameContrller = TextEditingController();
  final passwordContrller = TextEditingController();
  String error;
  void loginUser() async {
    if (userNameContrller.text.isEmpty || passwordContrller.text.isEmpty) {
      setState(() {
        error = "empty field";
      });
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
                    hintText: "User Name",
                    error: error != null ? "" : error,
                  ),
                  MyTextField(
                    obscureText: true,
                    hintText: "passowrd",
                    error: error,
                  ),
                  SizedBox(
                    height: 60,
                  ),

                  MyButton(
                    onTab: () {
                      // Navigator.pushNamed(context, '/chats');
                      loginUser();
                      setState(() {});
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
