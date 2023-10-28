import 'package:chatapp/utilites/config.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class UsersTab extends StatefulWidget {
  @override
  State<UsersTab> createState() => _UsersTabState();
}

class _UsersTabState extends State<UsersTab> {
  List<String> userList = [];

  @override
  void initState() {
    super.initState();
    connectToServer();
  }

  void connectToServer() {
    IO.Socket socket = IO.io(url, <String, dynamic>{
      'transports': ['websocket'],
    });
    socket.onConnect((_) {
      print('Connected to server');
    });
    socket.on('userList', (data) {
      setState(() {
        userList = List<String>.from(data.map((user) => user.name));
      });
    });
    socket.connect();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(userList[index]),
          );
        },
      ),
    );
  }
}
