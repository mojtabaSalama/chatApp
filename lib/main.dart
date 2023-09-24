import 'package:chatapp/pages/chats.dart';
import 'package:chatapp/pages/settings.dart';
import 'package:flutter/material.dart';

import 'pages/loading.dart';
import 'pages/login.dart';
import 'pages/register.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.green[600],
    ),
    initialRoute: '/loading',
    routes: {
      '/loading': (context) => Loading(),
      '/register': (context) => Register(),
      '/login': (context) => Login(),
      '/chats': (context) => Chats(),
      '/settings': (context) => Settings(),
    },
  ));
}
