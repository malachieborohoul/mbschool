import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content, [Color? backgroundColor]) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(content, style: TextStyle(color: Colors.white)),behavior: SnackBarBehavior.floating,backgroundColor: backgroundColor, padding: EdgeInsets.all(20),),);
}
