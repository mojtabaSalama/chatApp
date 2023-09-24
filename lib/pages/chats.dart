import 'package:chatapp/chats_tabs/Chats.dart';
import 'package:chatapp/chats_tabs/Users.dart';
import 'package:chatapp/chats_tabs/rooms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Chats extends StatefulWidget {
  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
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
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
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
                  Icons.settings,
                  size: 30.0,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
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
            UsersTab(),
            RoomsTab(),
          ]),
        ),
      ),
    );
  }
}
