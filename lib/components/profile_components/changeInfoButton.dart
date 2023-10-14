import 'package:flutter/material.dart';

class ChangInfoButton extends StatelessWidget {
  final String buttonText;
  final IconData buttonIcon;
  final Color color;
  final void Function() onTab;

  const ChangInfoButton(
      {Key key, this.onTab, this.buttonText, this.buttonIcon, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.grey[200],
      highlightColor: Colors.grey[200],
      onTap: onTab,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Icon(
              buttonIcon,
              color: color,
            ),
            SizedBox(
              width: 30,
            ),
            Text(buttonText,
                style: TextStyle(
                  color: color,
                  fontSize: 24.0,
                )),
          ],
        ),
      ),
    );
  }
}
