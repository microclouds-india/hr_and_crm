import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/repository/clock_in/clock_in_notifier/clock_IN_notifier.dart';
import 'package:hr_and_crm/repository/clock_out/model/clock_OUT_model.dart';
import 'package:hr_and_crm/repository/clock_out/notifier/clock_OUT_notifier.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelfieAttendanceScreen extends StatefulWidget {
  bool attend;
  SelfieAttendanceScreen({required this.attend});
  @override
  _SelfieAttendanceScreenState createState() => _SelfieAttendanceScreenState();
}

class _SelfieAttendanceScreenState extends State<SelfieAttendanceScreen> {
  // final double officeLatitude = 11.1995;
  // final double officeLongitude = 76.0642;
  // final double officeRadius = 500;
  // Geolocator geolocator = Geolocator();

  // bool isInOffice = false;
  // bool isAttendanceMarked = false;

  final picker = ImagePicker();
  String _imagePath = '';
  dynamic pickedFile;
  Future getImageFromCamera(ClockINNotifier notifier, bool attend,
      ClockOUTNotifier clockOUTNotifier) async {
    final prif = await SharedPreferences.getInstance();
    pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _imagePath = pickedFile.path;
        final dateFormate = DateFormat("dd-MM-yyyy").format(DateTime.now());
        // ignore: no_leading_underscores_for_local_identifiers
        String _currentTime = DateFormat.Hm().format(DateTime.now());
        if (notifier.isAttended == false) {
          notifier.clockIN(dateFormate.toString(), _currentTime.toString(),
              prif.getString('token')!, context);
          prif.setBool('auth', notifier.isAttended = true);
          notifier.isAttended = true;
        } else {
          clockOUTNotifier.clockOut(
            context: context,
              id: prif.getString('emploee_id')!,
              clockOuttime: dateFormate,
              attendDate: _currentTime);
          notifier.isAttended = false;
          prif.setBool('auth', notifier.isAttended = false);
        }
      } else {
        print('No image selected.');
      }
    });
  }

  // @override
  // void initState() {
  //   super.initState();

  //   // Geolocator.checkPermission().then((permission) {
  //   //   if (permission == LocationPermission.denied ||
  //   //       permission == LocationPermission.deniedForever) {
  //   //     Geolocator.requestPermission();
  //   //   }
  //   // });

  //   // Geolocator.getPositionStream().listen((position) {
  //   //   double distance = Geolocator.distanceBetween(position.latitude,
  //   //       position.longitude, officeLatitude, officeLongitude);

  //   //   if (distance <= officeRadius && !isInOffice && !isAttendanceMarked) {
  //   //     setState(() {
  //   //       isInOffice = true;
  //   //       isAttendanceMarked = true;
  //   //     });
  //   //   } else if (distance > officeRadius && isInOffice) {
  //   //     setState(() {
  //   //       isInOffice = false;
  //   //       isAttendanceMarked = false;
  //   //     });
  //   //   }
  //   // });

  // }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ClockINNotifier>(context, listen: false);
    final ClockOUT = Provider.of<ClockOUTNotifier>(context, listen: false);
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
              // isInOffice?
              data.isAttended
                  ? pickedFile == null
                      ? SizedBox()
                      : Image.file(
                          File(_imagePath),
                          height: 200,
                          width: 200,
                        )
                  : Text('Take a selfie to mark your attendance'),
              // : Container(),
              SizedBox(height: 20),
              // isInOffice?
              GestureDetector(
                onTap: () {
                  getImageFromCamera(data, data.isAttended, ClockOUT);
                },
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.pink.shade900,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Center(
                    child: Text(
                      'Take Selfi',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              // : Text('You are outside the office'),
              SizedBox(height: 20),
              data.isAttended
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
