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
  final int id;
  final String token;
  final String name;

  const UsersTab(
      {Key? key, required this.id, required this.token, required this.name})
      : super(key: key);
  @override
  State<UsersTab> createState() => _UsersTabState();
}

class _UsersTabState extends State<UsersTab> {
  var _users = [];

  @override
  void initState() {
    super.initState();
    allUSers();
  }

  void allUSers() async {
    var users = await getAllUSers(widget.token, widget.id);
    setState(() {
      users.removeWhere((user) => user['name'] == widget.name);
      _users = users;
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
                    onTap: () async {
                      Navigator.pushNamed(context, '/messageUser', arguments: {
                        'senderId': widget.id,
                        'token': widget.token,
                        'recieverId': user['id'],
                        'recieverName': user['name'],
                        'recieverProfilePic': user['profilePic'] ?? '',
                      });
                    },
                    leading: user['profilePic'] == null
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
