import 'package:flutter/material.dart';

class Ui {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> getSnackBar(
      {required title, required context}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.pink.shade900,
        content: Text(title),
      ),
    );
  }

  static BoxDecoration getBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5)),
      ],
      border: Border.all(color: Colors.black),
    );
  }

  static BoxDecoration getBoxDecorationWithoutBorder() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5)),
      ],
      border: Border.all(color: Colors.black.withOpacity(0.1)),
    );
  }

  static showAlertDialog(BuildContext context, String tittle, String content,
      VoidCallback ok, VoidCallback cancel) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: ok,
    );

    Widget cancelutton = TextButton(
      child: Text("Cancel"),
      onPressed: cancel,
    );

    AlertDialog alert = AlertDialog(
      title: Text(tittle),
      content: Text(content),
      actions: [
        cancelutton,
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


  static card(String title, String sub){
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              sub,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
