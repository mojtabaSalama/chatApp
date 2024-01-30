import 'package:chatapp/pages/chats.dart';
import 'package:chatapp/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/loading.dart';
import 'pages/login.dart';
import 'pages/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primaryColor: Colors.green[600],
        appBarTheme: AppBarTheme(color: Colors.green[600])),
    initialRoute: '/loading',
    routes: {
      '/loading': (context) => Loading(token: prefs.getString("token") ?? ""),
      '/register': (context) => Register(),
      '/login': (context) => Login(),
      '/chats': (context) => Chats(token: prefs.getString("token") ?? ""),
      '/profile': (context) => Profile(
            id: prefs.getInt("userId") ?? 0,
            token: prefs.getString("token") ?? "",
            name: prefs.getString("userName") ?? "",
          ),
    },
  ));
}
