import 'package:chatapp/functions.dart';
import 'package:chatapp/utilites/config.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;
import 'package:chatapp/pages/login.dart';
import 'package:chatapp/utilites/SPrefrencesData.dart';

class UsersTab extends StatefulWidget {
  @override
  State<UsersTab> createState() => _UsersTabState();
}

class _UsersTabState extends State<UsersTab> {
  var _users = [];
  late String name;
  late int id;
  late String token;

  @override
  void initState() {
    super.initState();
    loadSP().then((SPData) {
      setState(() {
        token = SPData[0];
        id = SPData[1] as int;
        name = SPData[2];
      });
      getAllUSers(token, id).then((users) {
        setState(() {
          users.removeWhere((user) => user['name'] == name);
          _users = users;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        child: _users.isNotEmpty
            ? ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  final user = _users[index];

                  return ListTile(
                    onTap: () {},
                    leading: user['profilePic'].isEmpty
                        ? CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 35,
                            child: Container(
                              child: Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.grey[200],
                            backgroundImage: NetworkImage(
                                url + "/api/user/" + user['profilePic'])),
                    title: Text(
                      user['name'],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  );
                },
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Let your friends join you ...",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Share app with your friends and text them now ! ",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
      ),
    );
  }
}
