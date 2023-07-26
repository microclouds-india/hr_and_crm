import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';

class CustomLeavesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pink.shade900,
        title: apBarText('Custom Leaves Screen', Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Custom Leaves',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView(
                children: [
                  _buildLeaveItem('Vacation', 'June 10 - June 15', 'Approved'),
                  _buildLeaveItem('Sick Leave', 'June 20', 'Pending'),
                  _buildLeaveItem('Personal', 'July 1 - July 5', 'Approved'),
                  _buildLeaveItem('Maternity Leave', 'August 8 - November 8', 'Cancel'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaveItem(String type, String duration, String status) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              type,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Duration: $duration',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Status: $status',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
