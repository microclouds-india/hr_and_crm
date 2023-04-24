import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/Leave%20Requests/Netwoking/leaveRequest_network.dart';
import 'package:hr_and_crm/repository/Leave%20Requests/notifier/leaveRequestsNotifier.dart';
import 'package:hr_and_crm/ui/leave%20request/reqestScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../LEAVE REQUEST POP UP ALERT TO TEAMLEADER AND HR EXECTIVE/leaveRequistPopup.dart';

class LeaveRequestScreen extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<leaveRequestNotifier>(context, listen: false);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink.shade900,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return RequestScreen();
          }));
        },
        child: Center(
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
                      bool? hr = prif.getBool('HR');
                      if (hr == true) {
                        showLeaveRequestAlert(context);
                      } else {}
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.pink.shade900,
                        child: Center(
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
                        style: TextStyle(
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
                            borderRadius: BorderRadius.all(Radius.circular(5))),
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

  void showLeaveRequestAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LeaveRequestAlert(
          title: 'Leave Request',
          message: 'Do you want to approve this leave request?',
          onAccept: () {
            // Handle approval logic here
            Navigator.of(context).pop();
          },
          onReject: () {
            // Handle rejection logic here
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
