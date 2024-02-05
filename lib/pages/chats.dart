import 'package:chatapp/chats_tabs/Chats.dart';
import 'package:chatapp/chats_tabs/Users.dart';
import 'package:chatapp/chats_tabs/rooms.dart';
import 'package:chatapp/components/alertdialog/dialogeMessage.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Chats extends StatefulWidget {
  final String token;
  final String name;
  final int id;

  const Chats(
      {Key? key, required this.token, required this.id, required this.name})
      : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  void deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    prefs.remove("userId");
    prefs.remove("userName");

    if (prefs.containsKey("profilePic")) {
      prefs.remove("profilePic");
    }

    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    DialogMessage dialog = DialogMessage(context, deleteToken);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 2.0,
          title: Text(
            "ChatApp",
            style: TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 3.0),
          ),
          centerTitle: true,
          leading: IconButton(
            splashRadius: 25.0,
            onPressed: () => dialog.dialog(context),
            icon: Icon(
              Icons.logout,
              size: 30.0,
            ),
          ),
          actions: [
            IconButton(
                splashRadius: 25.0,
                icon: Icon(
                  Icons.search,
                  size: 30.0,
                ),
                onPressed: () {}),
            IconButton(
                splashRadius: 25.0,
                icon: Icon(
                  Icons.person,
                  size: 30.0,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                }),
          ],
          bottom: TabBar(
            unselectedLabelColor: Colors.grey[300],
            indicatorWeight: 4.0,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            tabs: [
              Tab(
                text: "Chats",
              ),
              Tab(
                text: "Users",
              ),
              Tab(
                text: "Rooms",
              )
            ],
          ),
        ),
        body: Center(
          child: TabBarView(children: [
            Chatstab(),
            UsersTab(
              token: widget.token,
              id: widget.id,
              name: widget.name,
            ),
            RoomsTab(
              token: widget.token,
              id: widget.id,
              name: widget.name,
            ),
          ]),
        ),
      ),
    );
  }
}
