import 'package:flutter/material.dart';

void showGeneralSnakbar(
    {required BuildContext context,
    Icon? icon,
    String message = 'OK',
    Color backgroundColor = Colors.black,
    Duration duration = const Duration(milliseconds: 3000)}) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      duration: duration,
    ),
  );
}
