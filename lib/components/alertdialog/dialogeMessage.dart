import 'package:flutter/material.dart';
import 'package:chatapp/components/alertdialog/dialogButton.dart';

class DialogMessage {
  final BuildContext context;

  void Function() onPressed;

  DialogMessage(this.context, this.onPressed);

  void dialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actionsPadding: EdgeInsets.fromLTRB(0, 0, 10.0, 10.0),
            backgroundColor: Colors.grey[400],
            content: Text("Are you sure?", style: TextStyle(fontSize: 24)),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DialogButton(
                    onTab: () => {Navigator.pop(context)},
                    buttonText: "cancel",
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  DialogButton(
                    onTab: onPressed,
                    buttonText: "OK",
                  ),
                ],
              )
            ],
          );
        });
  }
}
