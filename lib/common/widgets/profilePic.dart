import 'package:flutter/material.dart';

Widget profilePic(img) {
  return Container(
      width: 30.0,
      height: 30.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage(img))));
}
