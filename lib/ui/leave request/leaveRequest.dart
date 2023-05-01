import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/repository/Leave%20Requests/notifier/leaveRequestsNotifier.dart';
import 'package:hr_and_crm/ui/leave%20request/reqestScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../repository/leave request responde/model.dart';
import 'leaveRequestAcceptAlert/leaveRequestAlert.dart';

class LeaveRequestScreen extends StatefulWidget {
  @override
  State<LeaveRequestScreen> createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen> {
  TextEditingController fromDate = TextEditingController();

  List status = [
    'Approved',
    'Not Approved',
    'Approved',
    'Not Approved',
    'Approved',
    'Not Approved',
    'Approved',
    'Not Approved',
  ];
  late LeaveRequestRespondModel leaveRequestRespondModel;

  postResponde(String id, String status, String comment, int index) async {
    String endpoint =
        'https://cashbes.com/attendance/apis/leave_request_respond';
    try {
      var url = Uri.parse(endpoint);
      var response = await http.post(url, body: {
        'id': id,
        'status': status,
        'comment': comment,
      });
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        // ignore: use_build_context_synchronously
        Ui.getSnackBar(title: json['data'][index]['status'], context: context);
        Navigator.of(context).pop();
      } else {
        print(response.statusCode);
        Ui.getSnackBar(title: "server down!", context: context);
        Navigator.of(context).pop();
      }
    } catch (e) {
      print('errorrrrrr$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<leaveRequestNotifier>(context, listen: false);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink.shade900,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const RequestScreen();
          }));
        },
        child: const Center(
          child: Icon(Icons.add),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        title: const Text(
          'Request Leave',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: data.getDatas(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: data.leaveRequestModel.data!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      final prif = await SharedPreferences.getInstance();
                      if (prif.getString('role')!.contains('hr') ||
                          prif.getString('role')!.contains('manager') ||
                          prif.getString('role')!.contains('Hr') ||
                          prif.getString('role')!.contains('Manager')) {
                        // ignore: use_build_context_synchronously
                        showLeaveRequestAlert(
                            context,
                            'Leave Request',
                            data.leaveRequestModel.data![index].reason ??
                                'No reason', () {
                          postResponde(
                              data.leaveRequestModel.data![index].employeeId!,
                              'accepted',
                              data.leaveRequestModel.data![index].reason ??
                                  'No reason',
                              index);
                        }, () {
                          postResponde(
                              data.leaveRequestModel.data![index].employeeId!,
                              'rejected',
                              data.leaveRequestModel.data![index].reason ??
                                  'No reason',
                              index);
                        });
                      }
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.pink.shade900,
                        child: const Center(
                          child: Text(
                            '08',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          ),
                        ),
                      ),
                      title: Text(
                        data.leaveRequestModel.data![index].reason ??
                            'No Reason',
                        style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'date:${data.leaveRequestModel.data![index].ldate}',
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Container(
                        height: 25,
                        width: 60,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: status[index] == 'Approved'
                                    ? Colors.green
                                    : Colors.red),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: Center(
                          child: Text(
                            'Approved',
                            style: TextStyle(
                                fontSize: 10,
                                color: status[index] == 'Approved'
                                    ? Colors.green
                                    : Colors.red),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.pink.shade900,
                ),
              );
            }
          }),
    );
  }

  void showLeaveRequestAlert(BuildContext context, String tittle, String body,
      VoidCallback onAccept, VoidCallback onReject) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LeaveRequestAlert(
            title: 'Leave Request',
            message: body,
            onAccept: onAccept,
            onReject: onReject);
      },
    );
  }
}
