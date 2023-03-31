import 'package:flutter/material.dart';

Widget submitContainer(BuildContext context,String txt) {
  return Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 20),
    child: Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.pink.shade900,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Center(
        child: Text(
          txt,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
