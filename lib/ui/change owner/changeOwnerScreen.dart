import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/common/widgets/bookingFormTextFields.dart';

class OwnershipChangeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        title: apBarText('Change Ownership', Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Owner:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Mirshad ',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'New Owner:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
           BookingFormTextFields(
            iconData: Icons.person,
            hint: 'Enter new owner name'),
            SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
  onPressed: () {},
  child: Text('Change ownership'),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.pink.shade900,
  ),
)


            ),
          ],
        ),
      ),
    );
  }
}
