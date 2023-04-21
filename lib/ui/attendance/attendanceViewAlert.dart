import 'package:flutter/material.dart';

class ViewAttendaceAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Date: 09/09/2000'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.calendar_today),
              SizedBox(width: 8.0),
              Text('Date: 09/09/2000'),
              Spacer(),
              Icon(Icons.access_time),
              SizedBox(width: 8.0),
              Text('Time: 09:29'),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            children: <Widget>[
              Icon(Icons.verified),
              SizedBox(width: 8.0),
              Text('Check out'),
            ],
          ),
        ],
      ),
    );
  }
}
