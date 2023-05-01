import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';

class SalaryViewScreen extends StatefulWidget {
  @override
  _SalaryViewScreenState createState() => _SalaryViewScreenState();
}

class _SalaryViewScreenState extends State<SalaryViewScreen> {
  final _salaryData = [
    {"month": "January", "amount": 5000},
    {"month": "February", "amount": 6000},
    {"month": "March", "amount": 7000},
    {"month": "April", "amount": 8000},
    {"month": "May", "amount": 9000},
    {"month": "June", "amount": 10000},
    {"month": "June", "amount": 10000},
    {"month": "August", "amount": 10000},
    {"month": "September", "amount": 10000},
    {"month": "October", "amount": 10000},
    {"month": "November", "amount": 10000},
    {"month": "December", "amount": 10000},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        title: apBarText('Salary Details', Colors.white),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _salaryData.length,
        itemBuilder: (BuildContext context, int index) {
          final data = _salaryData[index];
          return ListTile(
            title: Text(data["month"].toString()),
            subtitle: Text("\₹ ${data["amount"]}"),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            onTap: () {},
          );
        },
      ),
    );
  }
}
