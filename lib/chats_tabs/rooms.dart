import 'package:chatapp/functions.dart';
import 'package:chatapp/utilites/SPrefrencesData.dart';
import 'package:flutter/material.dart';

class RoomsTab extends StatefulWidget {
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
    loadSP().then((SPData) {
      setState(() {
        token = SPData[0];
        id = SPData[1] as int;
        name = SPData[2];
      });
      getAllRooms(token, id).then((rooms) {
        setState(() {
          _rooms = rooms;
        });
        print(rooms);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
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
                    "create or join a room ...",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Chat with your all friends at once !",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
      ),
    );
  }
}
