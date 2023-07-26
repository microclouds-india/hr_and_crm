import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/common/widgets/bookingFormTextFields.dart';
import 'package:hr_and_crm/common/widgets/submitContainer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class EmployeesDemoModel {
  final String id;
  final String name;

  EmployeesDemoModel({required this.id, required this.name});

  factory EmployeesDemoModel.fromJson(Map<String, dynamic> json) {
    return EmployeesDemoModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class ExpenseReportScreen extends StatefulWidget {
  @override
  _ExpenseReportScreenState createState() => _ExpenseReportScreenState();
}

class _ExpenseReportScreenState extends State<ExpenseReportScreen> {
  TextEditingController _dateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  late List<EmployeesDemoModel> employees;
  bool _dropDownLoad = false;
  EmployeesDemoModel? selectedEmployeesDemoModel;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('https://cashbes.com/attendance/apis/employees'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['status'] == '200') {
        final employeeData = data['data'] as List<dynamic>;
        employees =
            employeeData.map((e) => EmployeesDemoModel.fromJson(e)).toList();

        setState(() {
          selectedEmployeesDemoModel = employees[0];
          _dropDownLoad = true;
        });
      }
    }
  }

  void onChanged(EmployeesDemoModel? employee) {
    setState(() {
      selectedEmployeesDemoModel = employee;
    });

    if (selectedEmployeesDemoModel != null) {
      print('ID Endpoint: ${selectedEmployeesDemoModel!.id}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.pink.shade900,
          title: apBarText('ExpenseReportScreen', Colors.white)),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            _dropDownLoad
                ? Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                                width: 0.80),
                          ),
                          child: DropdownButton<EmployeesDemoModel>(
                            underline: SizedBox(),
                            value: selectedEmployeesDemoModel,
                            onChanged: onChanged,
                            items: employees.map((EmployeesDemoModel employee) {
                              return DropdownMenuItem<EmployeesDemoModel>(
                                value: employee,
                                child: Text(employee.name),
                              );
                            }).toList(),
                            isExpanded: false,
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(
                    color: Colors.pink.shade900,
                  )),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: BookingFormTextFields(
                  iconData: Icons.calendar_month,
                  hint: 'Date of Birth',
                  controller: TextEditingController(
                    text: _selectedDate != null ? _dateController.text : '',
                  ),
                ),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: (){},
              child: submitContainer(context, 'Download Report'))
          ],
        ),
      ),
    );
  }
}
