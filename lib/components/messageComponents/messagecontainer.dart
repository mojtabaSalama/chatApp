import 'package:flutter/material.dart';

class MessageContainer extends StatefulWidget {
  final void Function()? sendMessageFunc;
  final void Function()? emojiFunc;
  final void Function()? cameraFunc;
  const MessageContainer(
      {Key? key,
      required this.cameraFunc,
      required this.emojiFunc,
      required this.sendMessageFunc})
      : super(key: key);

  @override
  State<MessageContainer> createState() => _MessageContainerState();
}

class _MessageContainerState extends State<MessageContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
      child: Row(
        children: [
          IconButton(
              onPressed: () => widget.emojiFunc,
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
                constraints: BoxConstraints(maxHeight: 50, maxWidth: 310),
                border: InputBorder.none),
            cursorColor: Theme.of(context).primaryColor,
          ),
          IconButton(
              onPressed: () => widget.cameraFunc,
              icon: Icon(
                Icons.camera_alt,
                size: 30,
                color: Color.fromARGB(255, 194, 177, 177),
              )),
          IconButton(
              onPressed: () => widget.sendMessageFunc,
              icon: Icon(
                Icons.send,
                size: 30,
                color: Theme.of(context).primaryColor,
              )),
        ],
      ),
    );
  }
}
