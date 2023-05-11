import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Punch Attendance/punch_attendance.dart';
import '../Selfi attendance screen/selfiAttendance.dart';
import '../biometric scanning/biomatricScreen.dart';
import '../leave request/leaveRequest.dart';
import '../qr code scan/qrcodeScreen.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        elevation: 0,
        title: Text(
          "Attendance & Leaves",
          style: GoogleFonts.openSans(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Attendance Modes",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final prif = await SharedPreferences.getInstance();

                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return SelfieAttendanceScreen(
                          attend: prif.getBool('auth') ?? false,
                        );
                      }));
                    },
                    child: AttendanceChild(Icons.camera_alt_outlined,
                        "Selfie Attendance", Icons.radio_button_checked),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final prif = await SharedPreferences.getInstance();
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return PunchInAttendance(
                          token: prif.getString('token')!,
                        );
                      }));
                    },
                    child: AttendanceChild(Icons.punch_clock,
                        "Multiple Punch In", Icons.radio_button_checked),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return QrCodeScreen();
                      }));
                    },
                    child: AttendanceChild(Icons.qr_code_2_outlined,
                        "QR Attendance", Icons.arrow_forward_ios),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return BiometricScreen();
                      }));
                    },
                    child: AttendanceChild(Icons.fingerprint,
                        "Biometric Devices", Icons.arrow_forward_ios),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AttendanceChild(Icons.person_outline, "Attendance Kiosk",
                      Icons.arrow_forward_ios),
                  const SizedBox(
                    height: 10,
                  ),
                  AttendanceChild(Icons.phone_android_outlined,
                      "Phone Device Ownership", Icons.arrow_forward_ios),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey.shade300, thickness: 2),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
              child: Column(
                children: [
                  const Text(
                    "Leaves & Holidays",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return LeaveRequestScreen();
                      }));
                    },
                    child: AttendanceChild(Icons.request_page_outlined,
                        "Leave Requests", Icons.arrow_forward_ios),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AttendanceChild(Icons.calendar_month_sharp, "Holiday List",
                      Icons.arrow_forward_ios),
                  const SizedBox(
                    height: 10,
                  ),
                  AttendanceChild(Icons.request_page_outlined, "Custom Leaves",
                      Icons.arrow_forward_ios),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey.shade300, thickness: 2),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Column(
                children: [
                  const Text(
                    "Automation",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AttendanceChild(Icons.edit_calendar_outlined, "Auto-Present",
                      Icons.arrow_forward_ios),
                  const SizedBox(
                    height: 10,
                  ),
                  AttendanceChild(Icons.calendar_today_sharp, "Auto Half Day",
                      Icons.arrow_forward_ios),
                  const SizedBox(
                    height: 10,
                  ),
                  AttendanceChild(Icons.phone_android_outlined,
                      "Phone Device Ownership", Icons.arrow_forward_ios),
                  const SizedBox(
                    height: 10,
                  ),
                  AttendanceChild(Icons.phone_android_outlined,
                      "Phone Device Ownership", Icons.arrow_forward_ios),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget AttendanceChild(IconData icon, String text, IconData trailingIcon) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      children: [
        Icon(
          icon,
          color: Colors.grey,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(text),
        const Spacer(),
        Icon(
          trailingIcon,
          color: Colors.grey,
        ),
      ],
    ),
  );
}
