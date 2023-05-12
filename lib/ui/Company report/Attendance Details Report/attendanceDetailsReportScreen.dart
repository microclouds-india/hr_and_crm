import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfLib;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/common/widgets/submitContainer.dart';
import 'package:intl/intl.dart';

import '../../../repository/attendance report/model/attendanceReportModel.dart';

class AttendanceDetailedReport extends StatefulWidget {
  const AttendanceDetailedReport({super.key});

  @override
  State<AttendanceDetailedReport> createState() =>
      _AttendanceDetailedReportState();
}

final List<String> _dropdownValues = [
  "Branch One",
  "Brach Two",
  "Brach Three",
  "Brach Four",
  "Brach Five"
];
int groupValue = 1;

class _AttendanceDetailedReportState extends State<AttendanceDetailedReport> {
  DateTime _fromDaate = DateTime.now();
  DateTime _toDate = DateTime.now();
  final List<String> downloadmode = ["PDF", "CSV"];
  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _fromDaate == null ? DateTime.now() : _fromDaate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (picked != null && picked != _fromDaate) {
      setState(() {
        _fromDaate = picked;
      });
    }
  }

  Future<void> _selectTodate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _toDate == null ? DateTime.now() : _toDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (picked != null && picked != _toDate) {
      setState(() {
        _toDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String _fromDateView = DateFormat('MMMM dd').format(_fromDaate);
    String _toDateView = DateFormat('MMMM dd').format(_toDate);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        title: apBarText('Attendance Details Report', Colors.white),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'Select Branch',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            dropDown(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'Select Duration',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => _selectFromDate(context),
                  child: Container(
                    height: 30,
                    width: 150,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            color: Colors.black,
                          ),
                          Text(
                            _fromDateView,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Text(
                  'TO',
                  style: TextStyle(color: Colors.grey),
                ),
                GestureDetector(
                  onTap: () => _selectTodate(context),
                  child: Container(
                    height: 30,
                    width: 150,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            color: Colors.black,
                          ),
                          Text(
                            _toDateView,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'Select Format',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            downloadType(),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () async {
                  EasyLoading.show(status: 'loading...');
                  AttendanceReportModel model = AttendanceReportModel();
                  print(DateFormat('yyyy-MM-dd').format(_toDate));
                  var response = await http.post(
                      Uri.parse(
                          'https://cashbes.com/attendance/apis/attend_report'),
                      body: {
                        'employee_id': '31',
                        'from_date': '2023-05-01',
                        'to_date': '2023-05-08'
                      });
                  if (response.statusCode == 200) {
                    print(response.body);
                    var json = jsonDecode(response.body);
                    model = AttendanceReportModel.fromJson(json);
                    createPDF(model.data![0].name ?? 'No name', model, context,
                        model.data!.length);
                    EasyLoading.dismiss();
                  } else {
                    EasyLoading.dismiss();
                    print('reeee');
                  }
                },
                child: submitContainer(context, 'Download Report'))
          ],
        ),
      ),
    );
  }

  createPDF(String pdfName, AttendanceReportModel model, BuildContext ctx,
      int count) async {
    final pdf = pdfLib.Document();

    pdf.addPage(
      pdfLib.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pdfLib.Column(
            mainAxisAlignment: pdfLib.MainAxisAlignment.center,
            children: [
              pdfLib.Text(
                '$pdfName\'s Attendance Report',
                style: pdfLib.TextStyle(
                  fontSize: 24,
                  fontWeight: pdfLib.FontWeight.bold,
                ),
              ),
              pdfLib.SizedBox(height: 20),
              pdfLib.Column(
                children: [
                  pdfLib.Table.fromTextArray(
                    context: context,
                    headerCount: 1,
                    data: [
                      ["Attend Date", "Clock in", "Cock out", "Work Time"],
                      [
                        model.data!.map((e) => [e.attendDate]),
                        model.data!.map((e) => [e.clockIn]),
                        model.data!.map((e) => e.clockOut),
                        model.data!.map((e) => e.workTime)
                      ]
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    final dir = await getExternalStorageDirectory();
    final file = File('${dir!.path}/$pdfName\'s Report.pdf');
    await file.writeAsBytes(await pdf.save());
  }

  Row downloadType() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                  color: Colors.grey, style: BorderStyle.solid, width: 0.80),
            ),
            child: DropdownButton(
              underline: const SizedBox(),
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
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
