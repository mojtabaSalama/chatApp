import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  //token from main.dart
  final String token;

  const Loading({Key? key, required this.token}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();

//check if user logged in then open chat page, if not open register page
    if (widget.token.isNotEmpty) {
      Future(() {
        Navigator.pushReplacementNamed(context, '/chats');
      });
    } else {
      Future(() {
        Navigator.pushReplacementNamed(context, '/register');
      });
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
            //text in the middlle of the page
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
