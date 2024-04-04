
import 'package:flutter/material.dart';

class MessageRoom extends StatefulWidget {
  const MessageRoom({Key? key}) : super(key: key);

  @override
  State<MessageRoom> createState() => _MessageRoomState();
}

class _MessageRoomState extends State<MessageRoom> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map;
    String roomName = data["roomName"];
    Map roomMembers = data["roomMembers"] as Map;

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
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    child: Container(
                      child: Icon(
                        Icons.people,
                        size: 30,
                        color: Colors.grey,
                      ),
                    ),
                  )),
              Text(
                roomName,
                style: TextStyle(
                  fontSize: 35.0,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.grey[200],
        body: Container());
  }
}
