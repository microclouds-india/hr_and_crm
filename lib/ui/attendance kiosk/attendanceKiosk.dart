import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/widgets/bookingFormTextFields.dart';
// import 'package:kiosk_mode/kiosk_mode.dart';


class AttendanceKiosk extends StatelessWidget {
  const AttendanceKiosk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.pink.shade900,
            title: const Text('Attendance Kiosk'),
          ),
          body: const Center(child: _Home()),
  );
}

class _Home extends StatefulWidget {
  const _Home({
    Key? key,
  }) : super(key: key);

  @override
  State<_Home> createState() => _HomeState();
}

class _HomeState extends State<_Home> {
  // late final Stream<KioskMode> _currentMode = watchKioskMode();

  void _showSnackBar(String message) => ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message)));

  void _handleStart(bool didStart) {
    if (!didStart && Platform.isIOS) {
      _showSnackBar(
        'Single App mode is supported only for devices that are supervised'
        ' using Mobile Device Management (MDM) and the app itself must'
        ' be enabled for this mode by MDM.',
      );
    }
  }

  void _handleStop(bool? didStop) {
    if (didStop == false) {
      _showSnackBar(
        'Kiosk mode could not be stopped or was not active to begin with.',
      );
    }
  }

  @override
  Widget build(BuildContext context) => StreamBuilder(
        // stream: _currentMode,
        builder: (context, snapshot) {
          final mode = snapshot.data;

          return  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          
           BookingFormTextFields(
            iconData: Icons.person,
            hint: 'Enter your name'),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // TODO: Increment attendance for the user.
              },
              child: Text('Mark Attendance',style: TextStyle(
                color: Colors.pink.shade900
              ),),
            ),
          ],
        ),
      );
        },
      );
}