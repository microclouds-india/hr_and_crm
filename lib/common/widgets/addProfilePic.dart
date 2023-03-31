import 'package:flutter/material.dart';

Widget addProfilePic({required String imageUrl}) {
  return Stack(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
         imageUrl,
          height: 100.0,
          width: 100.0,
          fit: BoxFit.cover,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 50, left: 69),
        child: Container(
            decoration:
                BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            )),
      )
    ],
  );
}
