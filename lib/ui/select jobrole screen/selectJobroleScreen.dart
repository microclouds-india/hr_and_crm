import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/common/widgets/submitContainer.dart';

// ignore: use_key_in_widget_constructors
class JobRoleScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _JobRoleScreenState createState() => _JobRoleScreenState();
}

class _JobRoleScreenState extends State<JobRoleScreen> {
  List<String> jobRoles = [
    'Software Engineer',
    'Product Manager',
    'Data Analyst',
    'UX Designer',
    'Sales Executive',
    'Marketing Specialist',
  ];

  String? selectedJobRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: apBarText('Select Job Role', Colors.white),
        centerTitle: true,
        backgroundColor: Colors.pink.shade900,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Choose your desired job role:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: jobRoles.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    jobRoles[index],
                    style: TextStyle(fontSize: 18.0),
                  ),
                  onTap: () {
                    setState(() {
                      selectedJobRole = jobRoles[index];
                    });
                  },
                  tileColor: selectedJobRole == jobRoles[index]
                      ? Colors.pink[100]
                      : null,
                );
              },
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: (){
                  if (selectedJobRole != null) {
                  // Do something with the selected job role
                  print('Selected Job Role: $selectedJobRole');
                } else {
                  // showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return AlertDialog(
                  //       title: Text('Error'),
                  //       content: Text('Please select a job role.'),
                  //       actions: [
                  //         TextButton(
                  //           child: Text('OK'),
                  //           onPressed: () {
                  //             print(selectedJobRole);
                  //             Navigator.of(context).pop();
                  //           },
                  //         ),
                  //       ],
                  //     );
                  //   },
                  // );
                  Ui.getSnackBar(title: 'Please select a job role.', context: context);
                }
              },
              child: submitContainer(context, 'Confirm'))
          ],
        ),
      ),
    );
  }
}

