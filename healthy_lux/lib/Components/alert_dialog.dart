import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BuildAlertDialog {
  String title = "";
  String content = "";
  String buttonText = "";

  buildAlertDialog(
      BuildContext context, String title, String content, String buttonText) {
    Widget okButton = TextButton(
      child: Text(buttonText),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
