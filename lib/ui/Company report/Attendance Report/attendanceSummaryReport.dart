import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/common/widgets/submitContainer.dart';
import 'package:intl/intl.dart';

class AttendanceSummaryReport extends StatefulWidget {
  const AttendanceSummaryReport({super.key});

  @override
  State<AttendanceSummaryReport> createState() =>
      _AttendanceSummaryReportState();
}

final List<String> _dropdownValues = [
  "Branch One",
  "Brach Two",
  "Brach Three",
  "Brach Four",
  "Brach Five"
];
int groupValue = 1;

class _AttendanceSummaryReportState extends State<AttendanceSummaryReport> {
  DateTime _selectedDate = DateTime.now();
  final List<String> downloadmode = ["PDF", "CSV"];
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate == null ? DateTime.now() : _selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String viewDate = DateFormat('MMMM dd').format(_selectedDate);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        title: apBarText('Attendance Summary Report', Colors.white),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Select Branch',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            dropDown(),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Select Duration',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Container(
                    height: 30,
                    width: 150,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: Colors.black,
                          ),
                          Text(
                            viewDate,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Select Format',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            downloadType(),
            SizedBox(
              height: 20,
            ),
            submitContainer(context, 'Download Report')
          ],
        ),
      ),
    );
  }

  Row downloadType() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                  color: Colors.grey, style: BorderStyle.solid, width: 0.80),
            ),
            child: DropdownButton(
              underline: SizedBox(),
              items: downloadmode
                  .map((value) => DropdownMenuItem(
                        child: Text(value),
                        value: value,
                      ))
                  .toList(),
              onChanged: (String? value) {},
              isExpanded: false,
              value: downloadmode.first,
            ),
          ),
        ),
      ],
    );
  }

  Row dropDown() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                  color: Colors.grey, style: BorderStyle.solid, width: 0.80),
            ),
            child: DropdownButton(
              underline: SizedBox(),
              items: _dropdownValues
                  .map((value) => DropdownMenuItem(
                        child: Text(value),
                        value: value,
                      ))
                  .toList(),
              onChanged: (String? value) {},
              isExpanded: false,
              value: _dropdownValues.first,
            ),
          ),
        ),
      ],
    );
  }
}
