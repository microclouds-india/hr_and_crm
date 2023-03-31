import 'package:flutter/material.dart';

Widget apBarText(String txt,Color colors) {
  return Text(
    txt,
    style: TextStyle(
        color: colors, fontSize: 15, fontWeight: FontWeight.bold),
  );
}
