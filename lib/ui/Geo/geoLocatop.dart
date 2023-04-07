import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';


class GeofencingAttendanceApp extends StatefulWidget {
  @override
  _GeofencingAttendanceAppState createState() => _GeofencingAttendanceAppState();
}

class _GeofencingAttendanceAppState extends State<GeofencingAttendanceApp> {
  final double officeLatitude = 11.1195;
  final double officeLongitude = 76.1229;
  final double officeRadius = 50;

  // Initialize geolocator
  Geolocator geolocator = Geolocator();

  // Initialize variables for attendance status
  bool isInOffice = false;
  bool isAttendanceMarked = false;

  @override
  void initState() {
    super.initState();

    // Request location permission
    Geolocator.checkPermission().then((permission) {
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        Geolocator.requestPermission();
      }
    });

    // Start listening to location updates
    Geolocator.getPositionStream().listen((position) {
      double distance = Geolocator.distanceBetween(
          position.latitude, position.longitude, officeLatitude, officeLongitude);

      if (distance <= officeRadius && !isInOffice && !isAttendanceMarked) {
        // Mark attendance if inside office geofence
        setState(() {
          isInOffice = true;
          isAttendanceMarked = true;
        });
        _markAttendance();
      } else if (distance > officeRadius && isInOffice) {
        // Reset attendance status if outside office geofence
        setState(() {
          isInOffice = false;
          isAttendanceMarked = false;
        });
      }
    });
  }

  void _markAttendance() {
    // Get current date and time
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    String formattedTime = DateFormat('HH:mm:ss').format(now);

    // TODO: Mark attendance in database or file

    // Show attendance marked message
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Attendance marked'),
          content: Text('Attendance marked on $formattedDate at $formattedTime'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Geofencing Attendance'),
        ),
        body: Center(
          child: Text(
            isInOffice ? 'You are in the office' : 'You are outside the office',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
