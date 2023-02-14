import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showFlushBar(BuildContext context, String title) {
  Flushbar(
    isDismissible: true,
    messageSize: 16,
    messageText: Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    ),
    backgroundColor: const Color(0xff121556),
    flushbarPosition: FlushbarPosition.TOP,
    duration: const Duration(milliseconds: 2600),
  ).show(context);
}
