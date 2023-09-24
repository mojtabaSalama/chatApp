import 'package:flutter/material.dart';

class Chatstab extends StatefulWidget {
  @override
  State<Chatstab> createState() => _ChatstabState();
}

class _ChatstabState extends State<Chatstab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () => {},
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.amber,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "User Name",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            Text("3:14")
                          ],
                        ),
                        Text(
                          "massege",
                          style:
                              TextStyle(fontSize: 20, color: Colors.grey[500]),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
