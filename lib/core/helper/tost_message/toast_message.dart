import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMsg {
  static void error(String message) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static void success(String message) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static void info(String message) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static void alert(String message) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.yellow,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  static void warning(String message) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.orange,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static void api({
    required int? statusCode,
    dynamic data,
    String? msg,
  }) {
    String message = msg ??
        ((data?['message']?.toString().trim().isNotEmpty == true)
            ? data['message'].toString()
            : "Something went wrong. Please try again.");

    Color backgroundColor;
    Color textColor = Colors.white;
    int duration = 2;

    if (statusCode == null) {
      backgroundColor = Colors.grey;
      duration = 3;
    } else if (statusCode >= 200 && statusCode < 300) {
      backgroundColor = Colors.green;
      duration = 2;
    } else if (statusCode >= 400 && statusCode < 500) {
      backgroundColor = Colors.orange;
      duration = 3;
    } else if (statusCode >= 500) {
      backgroundColor = Colors.red;
      duration = 3;
    } else {
      backgroundColor = Colors.grey;
      duration = 3;
    }

    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: duration,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0,
    );
  }
}
