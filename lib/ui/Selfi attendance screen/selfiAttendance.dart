import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:image_picker/image_picker.dart';

class SelfieAttendanceScreen extends StatefulWidget {
  @override
  _SelfieAttendanceScreenState createState() => _SelfieAttendanceScreenState();
}

class _SelfieAttendanceScreenState extends State<SelfieAttendanceScreen> {
  final double officeLatitude = 11.1995;
  final double officeLongitude = 76.0642;
  final double officeRadius = 500;
  Geolocator geolocator = Geolocator();

  bool isInOffice = false;
  bool isAttendanceMarked = false;

  final picker = ImagePicker();
  String _imagePath = '';
  bool _isAttended = false;
  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _imagePath = pickedFile.path;
        _isAttended = true;
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    super.initState();

    Geolocator.checkPermission().then((permission) {
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        Geolocator.requestPermission();
      }
    });

    Geolocator.getPositionStream().listen((position) {
      double distance = Geolocator.distanceBetween(position.latitude,
          position.longitude, officeLatitude, officeLongitude);

      if (distance <= officeRadius && !isInOffice && !isAttendanceMarked) {
        setState(() {
          isInOffice = true;
          isAttendanceMarked = true;
        });
      } else if (distance > officeRadius && isInOffice) {
        setState(() {
          isInOffice = false;
          isAttendanceMarked = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back)),
            backgroundColor: Colors.pink.shade900,
            centerTitle: true,
            title: apBarText('Selfi Attendance', Colors.white)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isInOffice
                  ? _isAttended
                      ? Image.file(
                          File(_imagePath),
                          height: 200,
                          width: 200,
                        )
                      : Text('Take a selfie to mark your attendance')
                  : Container(),
              SizedBox(height: 20),
              isInOffice
                  ? GestureDetector(
                      onTap: getImageFromCamera,
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.pink.shade900,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Center(
                          child: Text(
                            'Take Selfi',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  : Text('You are outside the office'),
              SizedBox(height: 20),
              _isAttended
                  ? Text(
                      'You have marked your attendance',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
