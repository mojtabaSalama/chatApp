import 'package:chatapp/components/roomTabComponents/bottomSheet.dart';
import 'package:chatapp/functions.dart';
import 'package:chatapp/utilites/SPrefrencesData.dart';
import 'package:chatapp/utilites/config.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/components/roomTabComponents/icon.dart';
import 'package:chatapp/components/roomTabComponents/functions.dart';

class RoomsTab extends StatefulWidget {
  final int id;
  final String token;
  final String name;

  const RoomsTab(
      {Key? key, required this.id, required this.token, required this.name})
      : super(key: key);
  @override
  State<RoomsTab> createState() => _RoomsTabState();
}

class _RoomsTabState extends State<RoomsTab> {
  var _rooms = [];
  late String name;
  late int id;
  late String token;

  void initState() {
    super.initState();
    allRooms();
  }

  allRooms() async {
    var rooms = await getAllRooms(widget.token, widget.id);

    setState(() {
      _rooms = rooms;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController createRoomNamrController = TextEditingController();
    TextEditingController joinRoomNamrController = TextEditingController();

    void createRoomFunc = () => roomDatabase(
        createRoomNamrController, context, widget.id, widget.token, createRoom);
    void joinRoomFunc = () => roomDatabase(
        joinRoomNamrController, context, widget.id, widget.token, joinRoom);

    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Stack(children: [
        Container(
          child: _rooms.isNotEmpty
              ? ListView.builder(
                  itemCount: _rooms.length,
                  itemBuilder: (context, index) {
                    final room = _rooms[index];

                    return ListTile(
                      onTap: () {},
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                        child: Container(
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      title: Text(
                        room['name'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    );
                  },
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "create or join an existed room ...",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Chat with your all friends at once !",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 8, 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconsButton(
                      onPrssed: () => sheet(
                          createRoomNamrController,
                          context,
                          widget.id,
                          widget.token,
                          "room",
                          createRoomFunc,
                          "Enter room's name :",
                          "Create"),
                      buttonIcon: Icons.group_rounded),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconsButton(
                      onPrssed: () => sheet(
                          joinRoomNamrController,
                          context,
                          widget.id,
                          widget.token,
                          "room",
                          joinRoomFunc,
                          "Enter room's name :",
                          "Join"),
                      buttonIcon: Icons.person_add),
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
