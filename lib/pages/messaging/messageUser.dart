import 'package:chatapp/utilites/config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class MessageUser extends StatefulWidget {
  const MessageUser({Key? key}) : super(key: key);

  @override
  State<MessageUser> createState() => _MessageUserState();
}

class _MessageUserState extends State<MessageUser> {
  WebSocketChannel? _channel;
  List<dynamic> _users = [];
  late SharedPreferences prefs;
  String name = "";
  String token = "";
  Map data = {};

  @override
  void initState() {
    super.initState();
    setState(() {
      WebSocketChannel _channel = WebSocketChannel.connect(Uri.parse(ws));
    });
    initSharedPrefs();
  }

  void initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("userName")!;
      token = prefs.getString("token")!;
    });
  }

  void _sendMessage(message, messagedata) {
    final messageData = {
      'reciever': messagedata,
      'message': message,
      'token': token
    };
    final jsonData = json.encode(messageData);

    _channel?.sink.add(jsonData);
    _channel?.sink.close();
  }

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map;
    String recieverName = data["recieverName"];
    String recieverProfilePic = data["recieverProfilePic"];
    int recieverId = data["recieverId"];

    TextEditingController messageController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 2.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: recieverProfilePic.isEmpty
                    ? CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: Container(
                          child: Icon(
                            Icons.person,
                            size: 30,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: NetworkImage(
                            url + "/api/user/" + recieverProfilePic)),
              ),
              Text(
                recieverName,
                style: TextStyle(
                  fontSize: 35.0,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.grey[200],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0)),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () => print("hi"),
                        icon: Icon(
                          Icons.emoji_emotions_rounded,
                          size: 30,
                          color: Color.fromARGB(255, 194, 177, 177),
                        )),
                    TextField(
                      controller: TextEditingController(),
                      // maxLength: 10,
                      maxLines: 20,
                      decoration: InputDecoration(
                          hintText: "Message",
                          hintStyle: TextStyle(
                            fontSize: 20.0,
                          ),
                          constraints:
                              BoxConstraints(maxHeight: 50, maxWidth: 310),
                          border: InputBorder.none),
                      cursorColor: Theme.of(context).primaryColor,
                    ),
                    IconButton(
                        onPressed: () => print("hi"),
                        icon: Icon(
                          Icons.camera_alt,
                          size: 30,
                          color: Color.fromARGB(255, 194, 177, 177),
                        )),
                    IconButton(
                        onPressed: () =>
                            {_sendMessage(messageController.text, recieverId)},
                        icon: Icon(
                          Icons.send,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        )),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
