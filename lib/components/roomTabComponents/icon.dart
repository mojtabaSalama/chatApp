import 'package:flutter/material.dart';

class IconsButton extends StatelessWidget {
  final void Function() onPrssed;
  final IconData buttonIcon;

  const IconsButton(
      {Key? key, required this.onPrssed, required this.buttonIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Theme.of(context).primaryColor,
      onPressed: onPrssed,
      elevation: 2.0,
      child: Icon(
        buttonIcon,
        color: Colors.white,
        size: 40,
      ),
      padding: EdgeInsets.all(10.0),
      shape: CircleBorder(),
    );
  }
}
