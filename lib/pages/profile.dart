// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'dart:io';
import 'package:chatapp/components/UserInfoDialog/changeUser.dart';
import 'package:chatapp/components/roomTabComponents/joinRoom.dart';

import 'package:image_picker/image_picker.dart';

import 'package:chatapp/components/UserInfoDialog/changePassword.dart';
import 'package:chatapp/components/alertdialog/dialogButton.dart';
import 'package:chatapp/components/form_componenets/text_field.dart';

import 'package:flutter/material.dart';
import 'package:chatapp/components/profile_components/changeInfoButton.dart';
import 'package:http/http.dart' as http;
import 'package:chatapp/utilites/config.dart';

import 'package:chatapp/components/alertdialog/dialogeMessage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:chatapp/components/UserInfoDialog/changePassword.dart';

class Profile extends StatefulWidget {
  final int id;
  final String token;
  final String name;

  const Profile(
      {Key? key, required this.id, required this.token, required this.name})
      : super(key: key);
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController nameController = TextEditingController();

  MediaType? mediaType;
  late String error = "";
  late String name = "";

  late String _image = "";
  late String _showImage = "";
  late SharedPreferences prefs;
  late String profilePic = "";
  late String DBprofilePic = "";

  @override
  void initState() {
    super.initState();
    if (nameController.text.isEmpty) {
      setState(() {
        nameController.text = widget.name;
      });

      initSharedPrefs();
    }
  }

  void initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("profilePic")) {
      setState(() {
        profilePic = prefs.getString("profilePic")!;
        DBprofilePic = prefs.getString("profilePic")!;
      });
    } else {
      if (prefs.containsKey("DBprofilePic")) {
        setState(() {
          DBprofilePic = prefs.getString("DBprofilePic")!;
        });
      }
    }
    print(DBprofilePic);
  }

// -----------------------
  void _delteAcount() async {
    //print(id);
    var response = await http.post(
      Uri.parse(removeUser),
      headers: {
        'Content-Type': 'application/json',
        "x-auth-token": widget.token
      },
      body: jsonEncode({"id": widget.id}),
    );

    var status = response.statusCode;
    if (status != 200) {
      print(response.body);
    } else {
      await Navigator.pushReplacementNamed(context, '/register');
    }
  }

  void selectImage() async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (_file == null) {
      print("no image is selected");
    } else {
      setState(() {
        _image = _file.path;
      });
      final ext = path.extension(_file.path).toLowerCase();

      // set the contentType parameter based on the file extension

      if (ext == '.jpg' || ext == '.jpeg') {
        setState(() {
          mediaType = MediaType('image', 'jpeg');
        });
      } else if (ext == '.png') {
        setState(() {
          mediaType = MediaType('image', 'png');
        });
      } else if (ext == '.gif') {
        setState(() {
          mediaType = MediaType('image', 'gif');
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          padding: EdgeInsets.all(10),
          backgroundColor: Colors.red,
          content: Text('Unsupported file type: $ext'),
        ));
      }

      saveInDatabase();
    }
  }

  void saveInDatabase() async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(updateImage),
      );
      request.headers.addAll({
        'Content-Type': 'application/json',
        'x-auth-token': widget.token,
      });
      request.fields['id'] = widget.id.toString();
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          _image, // file path
          contentType: mediaType, // change file type accordingly
        ),
      );
      var response = await request.send();

      var decodedResponse =
          await jsonDecode(await response.stream.bytesToString());
      if (response.statusCode != 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          padding: EdgeInsets.all(10),
          backgroundColor: Colors.red,
          content: Text(decodedResponse["msg"]),
        ));
      }

      setState(() {
        _showImage = _image;
        setprofilePic();
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.all(10),
        content: Text(decodedResponse["msg"]),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.all(10),
        backgroundColor: Colors.red,
        content: Text("something wnt wrong"),
      ));
    }
  }

  void setprofilePic() async {
    await prefs.setString("profilePic", _image);
  }

  @override
  Widget build(BuildContext context) {
    DialogMessage dialog = DialogMessage(context, _delteAcount);
    TextEditingController currentPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController nameController = TextEditingController();

    // ChangePassword passwordBottomSheet =
    //     ChangePassword(context, widget.id, widget.token);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 2.0,
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: 28.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 80.0, 0, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 130,
                width: 130,
                child: Stack(
                  clipBehavior: Clip.none,
                  fit: StackFit.expand,
                  children: [
                    _showImage.isNotEmpty
                        ? CircleAvatar(
                            radius: 64,
                            backgroundColor: Colors.grey[200],
                            backgroundImage: FileImage(File(_showImage)))
                        : profilePic.isNotEmpty
                            ? CircleAvatar(
                                radius: 64,
                                backgroundColor: Colors.grey[200],
                                backgroundImage: FileImage(File(profilePic)))
                            : DBprofilePic.isNotEmpty
                                ? CircleAvatar(
                                    radius: 64,
                                    backgroundColor: Colors.grey[200],
                                    backgroundImage: NetworkImage(
                                        url + "/api/user/" + DBprofilePic))
                                : CircleAvatar(
                                    radius: 64,
                                    backgroundColor: Colors.white,
                                    child: Container(
                                      child: Icon(
                                        Icons.person,
                                        size: 100,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                    Positioned(
                        bottom: 0,
                        right: -25,
                        child: RawMaterialButton(
                          fillColor: Theme.of(context).primaryColor,
                          onPressed: selectImage,
                          elevation: 2.0,
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(10.0),
                          shape: CircleBorder(),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                name.isEmpty ? widget.name : name,
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: Divider(
                  height: 100.0,
                  thickness: 1,
                  color: Colors.grey[200],
                ),
              ),
              ChangInfoButton(
                onTab: () => editUserBottomSheet(
                    nameController, context, widget.id, widget.token),
                buttonText: "Edit name ",
                buttonIcon: Icons.edit,
                color: const Color.fromARGB(255, 61, 55, 55),
              ),
              ChangInfoButton(
                onTab: () => editPasswordBottomSheet(currentPasswordController,
                    newPasswordController, context, widget.id, widget.token),
                buttonText: "Change password ",
                buttonIcon: Icons.edit,
                color: const Color.fromARGB(255, 61, 55, 55),
              ),
              ChangInfoButton(
                onTab: () => dialog.dialog(context),
                buttonText: "Delete your account ",
                buttonIcon: Icons.delete,
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
