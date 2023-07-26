import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
// import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/common/widgets/bookingFormTextFields.dart';
import 'package:hr_and_crm/common/widgets/submitContainer.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repository/attendace_all/model/attendance_all_model.dart';
import '../Absent view/absent_view.dart';

class ViewAttendance extends StatefulWidget {
  String toke;
  ViewAttendance({required this.toke});

  @override
  State<ViewAttendance> createState() => _ViewAttendanceState();
}

class _ViewAttendanceState extends State<ViewAttendance> {
  DateTime _selectedDate = DateTime.now();
  List<Map<String, dynamic>> _dataList = [];

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
      print(DateFormat('yyyy-MM-dd').format(_selectedDate));
    }
  }

  List<Color> backgroundColor = [
    const Color(0xffCCFFCC),
    const Color(0xffFFFFCC),
    const Color(0xffFFCCCC),
    const Color(0xffFFFFCC),
    const Color(0xffFFCCFF)
  ];
  List<String> leave = ['Presend', 'Late', 'Absent', 'Half Day', 'Paid Leave'];
  List<Color> textClr = [
    Colors.green,
    Colors.yellow,
    Colors.pink,
    Colors.yellow,
    Colors.purple
  ];
  late AttendanceAllModel attendanceAllModel;

  getData() async {
    try {
      print(widget.toke);
      var response = await http.post(
          Uri.parse('https://cashbes.com/attendance/apis/attendance_all'),
          body: {'token': widget.toke});
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        attendanceAllModel = AttendanceAllModel.fromJson(json);
      }
    } catch (e) {
      Ui.getSnackBar(title: 'Data Not Availabe', context: context);
    }
    return attendanceAllModel;
  }

  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now();
  TextEditingController _fromDateController = TextEditingController();
  TextEditingController _toDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fromDateController = TextEditingController();
    _toDateController = TextEditingController();
  }

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fromDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _fromDate) {
      setState(() {
        _fromDate = picked;
        _fromDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _toDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _toDate) {
      setState(() {
        _toDate = picked;
        _toDateController.text = DateFormat('yyyy-MM-dd').format(picked);
        print(_toDateController.text);
      });
    }
  }

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String viewDate = DateFormat('MMMM dd').format(_selectedDate);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back)),
        actions: [
          TextButton.icon(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                  // set this when inner content overflows, making RoundedRectangleBorder not working as expected
                  clipBehavior: Clip.antiAlias,
                  // set shape to make top corners rounded
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return SingleChildScrollView(
                      child: Container(
                        height: 400,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  'Download Attendance Report',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () => _selectFromDate(context),
                                child: AbsorbPointer(
                                  child: BookingFormTextFields(
                                    iconData: Icons.calendar_month,
                                    controller: _fromDateController,
                                    hint: 'From Date',
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              GestureDetector(
                                onTap: () => _selectToDate(context),
                                child: AbsorbPointer(
                                  child: BookingFormTextFields(
                                    iconData: Icons.calendar_month,
                                    hint: 'To Date',
                                    controller: _toDateController,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    if (_toDateController.text.isEmpty &&
                                        _fromDateController.text.isEmpty) {
                                      Navigator.of(context).pop();
                                      Ui.getSnackBar(
                                          title: 'Please enter a value!',
                                          context: context);
                                    } else {
                                      try {
                                        EasyLoading.show(
                                            status: 'Please wait...');
                                        final prif = await SharedPreferences
                                            .getInstance();
                                        print(
                                            '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@${prif.getString('MyId')}');
                                        var response = await http.post(
                                            Uri.parse(
                                                'https://cashbes.com/attendance/apis/attend_report'),
                                            body: {
                                              'employee_id': prif
                                                  .getString('MyId')
                                                  .toString(),
                                              'from_date':
                                                  _fromDateController.text,
                                              'to_date': _toDateController.text
                                            });

                                        if (response.statusCode == 200) {
                                          print(response.body);
                                          var json = jsonDecode(response.body);
                                          final dataList =
                                              json['data'] as List<dynamic>;
                                          setState(() {
                                            _dataList = dataList
                                                .cast<Map<String, dynamic>>()
                                                .toList();
                                          });
                                          convertToCSV();
                                          Navigator.of(context).pop();

                                          EasyLoading.dismiss();
                                          Ui.getSnackBar(
                                              title: 'CSV created in download folder',
                                              context: context);
                                        } else {
                                          Navigator.of(context).pop();

                                          EasyLoading.dismiss();
                                          Ui.getSnackBar(
                                              title: 'Faild', context: context);
                                        }
                                      } catch (e) {
                                        EasyLoading.dismiss();
                                        Navigator.of(context).pop();
                                        Ui.getSnackBar(
                                            title: 'Data Not Availabe!',
                                            context: context);
                                      }
                                    }
                                  },
                                  child: submitContainer(context, 'Submit'))
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.download,
                color: Colors.white,
              ),
              label: const Text(
                'Download',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10),
              ))
        ],
        backgroundColor: Colors.pink.shade900,
        centerTitle: true,
        title: apBarText('Attendance', Colors.white),
        elevation: 0,
      ),
      body: Column(children: [
        Container(
          color: Colors.pink.shade900,
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                height: 30,
                width: 150,
                decoration: const BoxDecoration(
                    color: Colors.white,
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
                            color: Colors.black, fontWeight: FontWeight.bold),
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
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              leaveContainer(const Color(0xffCCFFCC), 'Presend', '0'),
              leaveContainer(const Color(0xffFFFFCC), 'Late', '0'),
              GestureDetector(
                  onTap: () => Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return AbsentViewScreen();
                      })),
                  child:
                      leaveContainer(const Color(0xffFFCCCC), 'Absent', '0')),
              leaveContainer(const Color(0xffFFFFCC), 'Half Day', '0'),
              leaveContainer(const Color(0xffFFCCFF), 'Paid Leave', '0')
            ],
          ),
        ),
        FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.pink.shade900,
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Data Not Available!'),
                );
              } else if (!snapshot.hasData) {
                return Center(
                  child: Text('Data Not Available!'),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: attendanceAllModel.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                    attendanceAllModel.data![index].name ??
                                        'No Name'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    popuoItem(
                                        index,
                                        attendanceAllModel
                                            .data[index].attendDate,
                                        Icons.calendar_month),
                                    popuoItem(
                                        index,
                                        'Clock in :${attendanceAllModel.data![index].clockIn!}',
                                        Icons.access_time),
                                    popuoItem(
                                        index,
                                        'Clock out :${attendanceAllModel.data![index].clockOut}',
                                        Icons.access_time),
                                    popuoItem(
                                        index,
                                        'Status :${attendanceAllModel.data![index].status}',
                                        Icons.mode),
                                    popuoItem(
                                        index,
                                        'Attendance type: ${attendanceAllModel.data![index].attendType}',
                                        Icons.mark_chat_read),
                                    popuoItem(
                                        index,
                                        'Work Time:${attendanceAllModel.data![index].workTime}',
                                        Icons.timer)
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: ListTile(
                          title: Text(
                            attendanceAllModel.data[index].attendDate,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(attendanceAllModel.data![index].name!),
                          // trailing: trailingContainer(backgroundColor[index],
                          //     attendanceAllModel.data![index].status??'', textClr[index]),
                          // trailing: Text(
                          //   attendanceAllModel.data![index].status ?? '',
                          //   style: TextStyle(
                          //       color: Colors.blue,
                          //       fontWeight: FontWeight.bold),
                          // ),
                        ),
                      );
                    },
                  ),
                );
              }
            })
      ]),
    );
  }

  Padding popuoItem(int index, String txt, IconData iconData) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Icon(
            iconData,
            color: Colors.pink.shade900,
          ),
          SizedBox(width: 10),
          Text(txt),
        ],
      ),
    );
  }

  Container trailingContainer(
      Color backgroundColor, String txt, Color textColor) {
    return Container(
      height: 25,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: backgroundColor,
      ),
      child: Center(
        child: Text(
          txt,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }

  Padding leaveContainer(Color color, String tittle, String count) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 70,
        width: 80,
        color: color,
        child: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(tittle),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    count,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }



Future<void> convertToCSV() async {
  if (_dataList.isNotEmpty) {
    final csvData = const ListToCsvConverter().convert(
      _dataList.map((item) => item.values.toList()).toList(),
    );
    final csvFileName = 'attendance_data.csv';
    final csvFilePath = await getNewFilePath(csvFileName);
    if (csvFilePath != null) {
      await createCsvFile(csvFilePath, csvData);
      print('CSV file created at $csvFilePath');
    } else {
      print('Unable to get file path');
    }
  } else {
    print('No data available to convert to CSV');
  }
}

Future<String?> getNewFilePath(String fileName) async {
  final directory = await getExternalStorageDirectory();
  if (directory != null) {
    final downloadsFolder = '/storage/emulated/0/Download/attend_report';
    final filePath = '$downloadsFolder/$fileName';

    // Create the directory if it doesn't exist
    if (!Directory(downloadsFolder).existsSync()) {
      Directory(downloadsFolder).createSync(recursive: true);
    }

    return filePath;
  }
  return null;
}

Future<void> createCsvFile(String csvFilePath, String csvData) async {
  final csvFile = File(csvFilePath);
  await csvFile.writeAsString(csvData);
}






}
