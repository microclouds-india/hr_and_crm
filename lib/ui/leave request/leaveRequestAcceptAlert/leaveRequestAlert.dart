import 'package:flutter/material.dart';

class LeaveRequestAlert extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  LeaveRequestAlert({
    required this.title,
    required this.message,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: onAccept,
          child: Text('Approve'),
        ),
        TextButton(
          onPressed: onReject,
          child: Text('Reject'),
        ),
      ],
    );
  }
  void showLeaveRequestAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return LeaveRequestAlert(
        
        title: 'Leave Request',
        message: 'Do you want to approve this leave request?',
        onAccept: () {
          // Handle approval logic here
          Navigator.of(context).pop();
        },
        onReject: () {
          // Handle rejection logic here
          Navigator.of(context).pop();
        },
      );
    },
  );
}

}