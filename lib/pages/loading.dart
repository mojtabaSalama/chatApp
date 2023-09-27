import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Loading extends StatefulWidget {
  final String token;

  const Loading({Key key, this.token}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();

    if (widget.token != null) {
      Future(() {
        Navigator.pushReplacementNamed(context, '/chats');
      });
    } else {
      Future(() {
        Navigator.pushReplacementNamed(context, '/register');
      });
      print(widget.token);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[600],
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "ChatApp",
              style: TextStyle(
                  fontSize: 44,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Colors.white),
            ),
            SizedBox(
              width: 10.0,
            ),
            SpinKitThreeBounce(
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
