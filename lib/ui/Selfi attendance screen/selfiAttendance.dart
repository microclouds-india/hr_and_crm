import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SelfieAttendanceScreen extends StatefulWidget {
  @override
  _SelfieAttendanceScreenState createState() => _SelfieAttendanceScreenState();
}

class _SelfieAttendanceScreenState extends State<SelfieAttendanceScreen> {
  File? _imageFile;

  Future<void> _captureImage() async {
    final imageFile = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      _imageFile = File(imageFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selfie Attendance'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_imageFile != null)
                Container(
                  margin: EdgeInsets.only(bottom: 32.0),
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: FileImage(_imageFile!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ElevatedButton(
                onPressed: _captureImage,
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                ),
                child: Text(
                  'Capture Selfie',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
