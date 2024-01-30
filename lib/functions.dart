import 'dart:convert';

import 'package:chatapp/utilites/config.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>> getAllUSers(token, id) async {
  List<dynamic> users = [];
  var response = await http.post(
    Uri.parse(getAllUsers),
    headers: {
      'Content-Type': 'application/json',
      "x-auth-token": token,
    },
    body: jsonEncode({"id": id}),
  );
  var decodedRespons = await jsonDecode(response.body);

  // print(decodedRespons["token"]);
  var status = response.statusCode;
  if (status != 200) {
    print(decodedRespons["msg"]);
  } else {
    users = decodedRespons["users"];
  }
  return users;
}

Future<List<dynamic>> getAllRooms(token, id) async {
  List<dynamic> rooms = [];
  var response = await http.post(
    Uri.parse(allRooms),
    headers: {
      'Content-Type': 'application/json',
      "x-auth-token": token,
    },
    body: jsonEncode({"id": id}),
  );

  var decodedRespons = await jsonDecode(response.body);

  // print(decodedRespons["token"]);
  var status = response.statusCode;
  if (status != 200) {
    print(decodedRespons["msg"]);
  } else {
    rooms = decodedRespons["rooms"];
  }
  return rooms;
}
