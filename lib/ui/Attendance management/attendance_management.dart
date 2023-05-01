import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';

import '../attendance/attendancePage.dart';
import '../attendance/viewAttendanceScreen.dart';
import '../leave request/leaveRequest.dart';

class AttendanceManagement extends StatelessWidget {
  bool hr;
  AttendanceManagement({required this.hr});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        title: apBarText('Attendance Management', Colors.white),
        centerTitle: true,
      ),
      body: Column(
        children: [
          GestureDetector(
              onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return AttendancePage();
                  })),
              child: ateendanceTile('Attendance & Leaves')),
          GestureDetector(
              child: ateendanceTile('Attendace History'),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ViewAttendance();
                }));
              }),
          // Visibility(
          //   visible: hr,
          //   child: GestureDetector(
          //       child: ateendanceTile('Leave Requestes'),
          //       onTap: () {
          //         Navigator.of(context)
          //             .push(MaterialPageRoute(builder: (context) {
          //           return LeaveRequestScreen();
          //         }));
          //       }),
          // )
        ],
      ),
    );
  }

  Padding ateendanceTile(String txt) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListTile(
        title: Text(txt),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.grey,
        ),
      ),
    );
  }
}
