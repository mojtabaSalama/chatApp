import 'dart:convert';

import 'dart:io';
import 'package:chatapp/components/snackbar/snackBar.dart';
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

class Profile extends StatefulWidget {
  final int id;
  final String token;
  final String name;

  const Profile({Key key, this.id, this.token, this.name}) : super(key: key);
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController nameController = TextEditingController();

  MediaType mediaType;
  String error;
  String name;

  String _image;
  String _showImage;
  SharedPreferences prefs;
  String profilePic;
  String DBprofilePic;

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
        profilePic = prefs.getString("profilePic");
        DBprofilePic = prefs.getString("DBprofilePic");
      });
    }
  }

// ----------------------------------

  void editName() async {
    try {
      if (nameController.text.isEmpty) {
        showSnackBar(context, "Name can't be empty", "error");
      } else {
        var response = await http.post(
          Uri.parse(updateName),
          headers: {
            'Content-Type': 'application/json',
            "x-auth-token": widget.token
          },
          body: jsonEncode({"id": widget.id, "name": nameController.text}),
        );
        var decodedRespons = await jsonDecode(response.body);
        if (response.statusCode != 200) {
          setState(() {
            error = decodedRespons["msg"];
          });
        } else {
          setState(() {
            name = nameController.text;
          });
          await prefs.setString("userName", name);
          Navigator.pop(context);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void editUserBottomSheet(context) {
    nameController.text = name;
    try {
      showModalBottomSheet(
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Enter your name :",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                    MyTextField(
                      controller: nameController,
                      obscureText: false,
                      hintText: "name",
                      error: error,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          DialogButton(
                            onTab: () => {Navigator.pop(context)},
                            buttonText: "Cancel",
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          DialogButton(
                            onTab: editName,
                            buttonText: "OK",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    } catch (e) {
      print(e);
    }
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
    XFile _file = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (_file == null) {
      print("no image is selected");
    }
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
      showSnackBar(context, 'Unsupported file type: $ext', "error");
    }

    saveInDatabase();
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
        showSnackBar(context, decodedResponse["msg"], "error");
      }

      setState(() {
        _showImage = _image;
        setprofilePic();
      });
      showSnackBar(context, decodedResponse["msg"], null);
    } catch (e) {
      showSnackBar(context, "something went wrong ", "error");
    }
  }

  void setprofilePic() async {
    await prefs.setString("profilePic", _image);
  }

  @override
  Widget build(BuildContext context) {
    DialogMessage dialog = DialogMessage(context, _delteAcount);
    ChangePassword passwordBottomSheet =
        ChangePassword(context, widget.id, widget.token);

    return Scaffold(
      appBar: AppBar(
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
                    _showImage == null &&
                            profilePic == null &&
                            DBprofilePic == null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundColor: Colors.white,
                            child: Container(
                              child: Icon(
                                Icons.person,
                                size: 100,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : CircleAvatar(
                            radius: 64,
                            backgroundColor: Colors.grey[200],
                            backgroundImage: _showImage != null
                                ? FileImage(File(_showImage))
                                : profilePic != null
                                    ? FileImage(File(profilePic))
                                    : NetworkImage(
                                        url + "/api/user/" + DBprofilePic),
                          ),
                    Positioned(
                        bottom: 0,
                        right: -25,
                        child: RawMaterialButton(
                          fillColor: Colors.green[600],
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
                name == null ? widget.name : name,
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
                onTab: () => editUserBottomSheet(context),
                buttonText: "Edit name ",
                buttonIcon: Icons.edit,
                color: Colors.grey[600],
              ),
              ChangInfoButton(
                onTab: () =>
                    passwordBottomSheet.editPasswordBottomSheet(context),
                buttonText: "Change password ",
                buttonIcon: Icons.edit,
                color: Colors.grey[600],
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
