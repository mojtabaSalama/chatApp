import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void showSnackBar(context, msg, status) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    padding: EdgeInsets.all(10),
    backgroundColor: status == "error" ? Colors.red : Colors.green[600],
    content: Text(msg),
  ));
}
