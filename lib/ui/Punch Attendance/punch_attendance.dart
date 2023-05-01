import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:intl/intl.dart';

class PunchInAttendance extends StatefulWidget {
  @override
  _PunchInAttendanceState createState() => _PunchInAttendanceState();
}

class _PunchInAttendanceState extends State<PunchInAttendance> {
  late DateTime _punchInTime;
  late DateTime _punchOutTime;

  String _formattedPunchInTime = '';
  String _formattedPunchOutTime = '';

  bool _isPunchedIn = false;
  bool _isPunchedOut = false;

  void _punchIn() {
    setState(() {
      _punchInTime = DateTime.now();
      _formattedPunchInTime = DateFormat('hh:mm a').format(_punchInTime);
      _isPunchedIn = true;
    });
  }

  void _punchOut() {
    setState(() {
      _punchOutTime = DateTime.now();
      _formattedPunchOutTime = DateFormat('hh:mm a').format(_punchOutTime);
      _isPunchedOut = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        centerTitle: true,
        title: apBarText('Attendance', Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Punch In Time:',
            ),
            SizedBox(height: 10),
            Text(
              _isPunchedIn ? _formattedPunchInTime : 'Not Punched In',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Text(
              'Punch Out Time:',
            ),
            SizedBox(height: 10),
            Text(
              _isPunchedOut ? _formattedPunchOutTime : 'Not Punched Out',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton(
            backgroundColor: Colors.pink.shade900,
            onPressed: _isPunchedIn ? null : _punchIn,
            tooltip: 'Punch In',
            child: Icon(Icons.login),
          ),
          FloatingActionButton(
            backgroundColor: Colors.pink.shade900,
            onPressed: _isPunchedOut ? null : _punchOut,
            tooltip: 'Punch Out',
            child: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
