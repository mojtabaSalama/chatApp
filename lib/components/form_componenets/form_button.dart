import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String buttonText;
  final void Function() onTab;

  const MyButton({
    Key key,
    this.onTab,
    this.buttonText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        width: 320,
        height: 70,
        decoration: BoxDecoration(
            color: Colors.green[600],
            borderRadius: BorderRadius.circular(15.0)),
        child: Center(
            child: Text(buttonText,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,
                ))),
      ),
    );

    // ElevatedButton(
    //   onPressed: onPressed,
    //   child: Text(
    //     buttonText,
    //     style: TextStyle(
    //       color: Colors.white,
    //       fontWeight: FontWeight.bold,
    //       fontSize: 28.0,
    //     ),
    //   ),
    //   style: ButtonStyle(
    //       backgroundColor: MaterialStateProperty.all(
    //         Colors.green[600],
    //       ),
    //       padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
    //           EdgeInsets.symmetric(horizontal: 80.0, vertical: 10.0)),
    //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    //           RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(15.0)))),
//    );
  }
}
