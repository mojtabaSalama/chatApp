import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  final String buttonText;

  final void Function() onTab;

  const DialogButton({Key? key, required this.onTab, required this.buttonText})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30.0),
      splashColor: Colors.grey[500],
      highlightColor: Colors.green[100],
      onTap: onTab,
      child: Container(
        child: Text(buttonText,
            style: TextStyle(
              color: Colors.green[600],
              fontSize: 24.0,
            )),
      ),
    );
  }
}
