import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/common/widgets/bookingFormTextFields.dart';
import 'package:hr_and_crm/common/widgets/submitContainer.dart';
import 'package:hr_and_crm/repository/DataBase/db.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;


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

class AbsendReportScreen extends StatefulWidget {
  @override
  _AbsendReportScreenState createState() => _AbsendReportScreenState();
}

class _AbsendReportScreenState extends State<AbsendReportScreen> {
  String _employeeID = '';
  TextEditingController _dateControllerfrom = TextEditingController();
  DateTime _selectedfromDate = DateTime.now();

  TextEditingController _dateControllerto = TextEditingController();
  DateTime _selectedtoDate = DateTime.now();

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedfromDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedfromDate) {
      setState(() {
        _selectedfromDate = picked;
        _dateControllerfrom.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedtoDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedtoDate) {
      setState(() {
        _selectedtoDate = picked;
        _dateControllerto.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  void dispose() {
    _dateControllerfrom.dispose();
    _dateControllerto.dispose();
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
      // print('ID Endpoint: ${selectedEmployeesDemoModel!.id}');
      _employeeID = selectedEmployeesDemoModel!.id;
      print(_employeeID);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.pink.shade900,
          title: apBarText('Absend Report', Colors.white)),
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
              onTap: () => _selectFromDate(context),
              child: AbsorbPointer(
                child: BookingFormTextFields(
                  iconData: Icons.calendar_month,
                  hint: 'From Date',
                  controller: TextEditingController(
                    text: _selectedfromDate != null
                        ? _dateControllerfrom.text
                        : '',
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: () => _selectToDate(context),
              child: AbsorbPointer(
                child: BookingFormTextFields(
                  iconData: Icons.calendar_month,
                  hint: 'To Date',
                  controller: TextEditingController(
                    text: _selectedtoDate != null ? _dateControllerto.text : '',
                  ),
                ),
              ),
            ),
            Spacer(),
            GestureDetector(
                onTap: () async {
                  if (_employeeID.isEmpty ||
                      _dateControllerfrom.text.isEmpty ||
                      _dateControllerto.text.isEmpty) {
                    Ui.getSnackBar(
                        title: 'Please Enter Values!', context: context);
                  } else {
                    EasyLoading.show(status: 'Please Wait');
                    var uri = Uri.parse(
                        'https://cashbes.com/attendance/apis/absent_report');
                    var response = await http.post(uri, body: {
                      'employee_id': _employeeID,
                      'from_date': _dateControllerfrom.text,
                      'to_date': _dateControllerto.text,
                    });
                    var json = jsonDecode(response.body);
                    print(response.body);
                    if (json['status'] == '200') {
                      print(response.body);
                      
                      generateReportFromAPI(response.body);
                      EasyLoading.dismiss();
                      Ui.getSnackBar(
                          title: 'Download Completed', context: context);
                    } else {
                      EasyLoading.dismiss();
                      Ui.getSnackBar(
                          title: 'Report not availabe!', context: context);
                    }
                  }
                },
                child: submitContainer(context, 'Download Report'))
          ],
        ),
      ),
    );
  }
Future<File> generateReportFromAPI(String apiResponse) async {
  final data = json.decode(apiResponse);
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Absent Report', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            for (var item in data['data'])
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('ID: ${item['id']}'),
                  pw.Text('Name: ${item['name']}'),
                  pw.Text('Date: ${item['attend_date']}'),
                  pw.Text('Clock In: ${item['clock_in']}'),
                  pw.Text('Clock Out: ${item['clock_out']}'),
                  pw.Text('Work Time: ${item['work_time']}'),
                  pw.SizedBox(height: 10),
                ],
              ),
          ],
        );
      },
    ),
  );
 final dir = await getExternalStorageDirectory();
    final file = File('${dir!.path}/absent\'s Report.pdf');
    await file.writeAsBytes(await pdf.save());
    addLocalDataBase('${data['name']}absent', 'test', 'date', file.path);
  return file;
}

}
