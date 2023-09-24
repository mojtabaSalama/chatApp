import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.pushReplacementNamed(context, '/register');
    });
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
