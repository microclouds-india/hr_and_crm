import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/repository/Employee%20View/employeeViewMode.dart';
import 'package:hr_and_crm/repository/employees/model/employee.model.dart';
import 'package:hr_and_crm/repository/remove%20workreport/remove%20workreport.dart';
import 'package:hr_and_crm/repository/workreports/model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Notes/writeNoteScreen.dart.dart';
import '../edit workreport/editWorkreport.dart';

class DailyReport {
  final String date;
  final String title;
  final String description;

  DailyReport(
      {required this.date, required this.title, required this.description});
}

class DailyReportListScreen extends StatefulWidget {
  @override
  State<DailyReportListScreen> createState() => _DailyReportListScreenState();
}

class _DailyReportListScreenState extends State<DailyReportListScreen> {
  late WorkReportsModel model;

  late EmployeesModel _employeesModel;

  Future<WorkReportsModel> fetchReports(BuildContext context) async {
    try {
      final prif = await SharedPreferences.getInstance();
      var url = 'https://cashbes.com/attendance/apis/employee_work_reports';
      var response = await http.post(Uri.parse(url), body: {
        'token': prif.getString('token').toString(),
      });
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        model = WorkReportsModel.fromJson(json);
      }
    } catch (e) {
      Ui.getSnackBar(title: 'Reports Not Available', context: context);
    }
    return model;
  }

  @override
  Widget build(BuildContext context) {
    final deleteReport= Provider.of<RemoveWorkreportNotifier>(context,listen: false);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return WriteNoteScreen();
          })),
          backgroundColor: Colors.pink.shade900,
          child: const Center(
            child: Icon(Icons.add),
          ),
        ),
        appBar: AppBar(
          title: apBarText('Work Reports', Colors.white),
          centerTitle: true,
          backgroundColor: Colors.pink.shade900,
        ),
        body: FutureBuilder(
            future: fetchReports(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.pink.shade900,
                  ),
                );
              } else if (!snapshot.hasData) {
                return const Center(
                  child: Text('Empty...'),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.data
                      .length, // Replace with your actual data length
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 1),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.work,
                            color: Colors.pink.shade900,
                          ),
                          title: Text(
                            snapshot.data!.data[index].reportMessage,
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis),
                          ),
                          subtitle: Text(
                            DateFormat('dd-mm-yyyy')
                                .format(snapshot.data!.data[index].reportDate),
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis),
                          ),
                          trailing: IconButton(onPressed: (){
                            Ui.showAlertDialog(context, 'Confirmation', 'Are you sure you want to remove this work report?', () { 
                              deleteReport.removeWorkreport(snapshot.data!.data[index].id, context);
                              Navigator.of(context).pop();
                              setState(() {});
                            }, () {Navigator.of(context).pop();});
                          }, icon: Icon(Icons.delete,color: Colors.red.shade900,)),
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return DailyReportDetails(
                                  date: DateFormat('dd-mm-yyyy').format(snapshot.data!.data[index].reportDate),
                                  id: model.data[index].employeeId,
                                  report: model.data[index].reportMessage
                                      .toString());
                            }));
                          },
                        ),
                      ),
                    );
                  },
                );
              }
            }));
  }
}

class DailyReportDetails extends StatelessWidget {
  String id;
  String date;
  String report;
  DailyReportDetails(
      {required this.id, required this.date, required this.report});

  late EmployeeViewModel model;
  fetchUser(BuildContext context) async {
    try {
      var url = 'https://cashbes.com/attendance/apis/employee_view';
      var response = await http.post(Uri.parse(url), body: {'id': id});
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        model = EmployeeViewModel.fromJson(json);
      }
    } catch (e) {
      Ui.getSnackBar(title: 'User not available', context: context);
    }
    return model;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return DailyReportListScreen();
        }));
        return true;
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return WorkReportEditScreen(
              message: report,
              title: 'yuio',
            );
          }));
        },child: Center(child: Icon(Icons.edit)),backgroundColor: Colors.pink.shade900,),
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        centerTitle: true,
        title: apBarText('Work Report Details', Colors.white),
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
      ),
      body: FutureBuilder(
        future: fetchUser(context),
        builder: (context,snapshot) {
         if (snapshot.connectionState == ConnectionState.waiting) {
           return Center(
            child: CircularProgressIndicator(
              color: Colors.pink.shade900,
            ),
           );
         }else if(snapshot.hasData){
           return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: const Text(
                        'Date:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        date,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Employee Name:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        model.data[0].name,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Report',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        report,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
         }else{
           return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        'Date:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        date,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Employee Name:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Employee name not available',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Report',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'employeeName uiwqd',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
         }
        }
      ),
    )
    );
  }
}
