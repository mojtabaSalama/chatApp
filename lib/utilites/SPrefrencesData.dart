import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

Future<List<dynamic>> loadSP() async {
  prefs = await SharedPreferences.getInstance();
  var userId = prefs.getInt("userId");
  var userName = prefs.getString("userName");

  var token = prefs.getString("token");
  var profilePic = prefs.getString("DBprofilePic");

  List<dynamic> data = [
    token,
    userId,
    userName,
    profilePic,
  ];

  return data;
}
