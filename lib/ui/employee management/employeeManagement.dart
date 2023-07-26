import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/ui/Employee%20expense/employeeExpenceScreen.dart';

import '../Employees/Documents/documents.dart';
import '../Employees/employees.dart';

class EmployeeManagement extends StatelessWidget {
  const EmployeeManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        title: apBarText('Employee Management', Colors.white),
        centerTitle: true,
      ),
      body: Column(
        children: [
          GestureDetector(
              onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return EmployeesScreen();
                  })),
              child: ateendanceTile('Employees')),
          GestureDetector(
              child: ateendanceTile('Employee Documents'),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return EmployeeDocuments();
                }));
              }),
          GestureDetector(
              child: ateendanceTile('Employee Expense'),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return EmployeeExpenseScreen();
                }));
              }),
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
