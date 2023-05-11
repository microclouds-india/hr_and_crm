import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.pink.shade900,
          title: apBarText("Notifications", Colors.white)),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return NotificationItem(
            title: 'Notification Title',
            message: 'Notification message goes here.',
            time: 'Just now',
            isRead: false,
          );
        },
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String title;
  final String message;
  final String time;
  final bool isRead;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isRead
            ? Colors.white
            : Colors.grey[
                100], 
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200]!,
            width: 1.0,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.notifications,
            color: isRead
                ? Colors.grey[500]
                : Colors.pink
                    .shade900, 
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: isRead
                        ? FontWeight.normal
                        : FontWeight
                            .bold, 
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  message,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  time,
                  style: TextStyle(
                    color: isRead
                        ? Colors.grey[500]
                        : Colors.pink
                            .shade900,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
