// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';

class MySnackbar {
  static void show(BuildContext context, String text) {
    if (context == null) return;
    FocusScope.of(context).requestFocus(FocusNode());

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        backgroundColor: Colors.black,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
