import 'package:flutter/material.dart';

class Ui {

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> getSnackBar({required title, required context}) {
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
        BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5)),
      ],
      border: Border.all(color: Colors.black),
    );
  }

  static BoxDecoration getBoxDecorationWithoutBorder() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5)),
      ],
      border: Border.all(color: Colors.black.withOpacity(0.1)),
    );
  }

}