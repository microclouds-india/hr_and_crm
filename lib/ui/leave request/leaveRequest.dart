import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/ui/leave%20request/reqestScreen.dart';
import 'package:http/http.dart' as http;

class LeaveRequest {
  final String id;
  final String employeeId;
  final String leaveDate;
  final String reason;
  final String toDate;
  final String toTime;
  String status;
  String comment;

  LeaveRequest({
    required this.id,
    required this.employeeId,
    required this.leaveDate,
    required this.reason,
    required this.toDate,
    required this.toTime,
    required this.status,
    required this.comment,
  });
}

class LeaveRequestScreen extends StatefulWidget {
  @override
  _LeaveRequestScreenState createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen> {
  List<LeaveRequest> leaveRequests = [];

  Future<void> fetchLeaveRequests() async {
    final url = Uri.https('cashbes.com', '/attendance/apis/leave_requests');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['status'] == '200') {
        final List<dynamic> data = responseData['data'];
        leaveRequests = data
            .map((item) => LeaveRequest(
                  id: item['employee_id'],
                  employeeId: item['employee_id'],
                  leaveDate: item['ldate'],
                  reason: item['reason'],
                  toDate: item['tdate'],
                  toTime: item['ttime'],
                  status: 'pending', // Set initial status to 'pending'
                  comment: '',
                ))
            .toList();

        setState(() {});
      }
    }
  }

  Future<void> respondToLeaveRequest(
      LeaveRequest leaveRequest, String status, String comment) async {
    final url =
        Uri.https('cashbes.com', '/attendance/apis/leave_request_respond');
    final response = await http.post(url, body: {
      'id': leaveRequest.id,
      'status': status,
      'comment': comment,
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['status'] == '200') {
        setState(() {
          leaveRequest.status = status;
          leaveRequest.comment = comment;
        });

        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Success'),
            content: Text(responseData['message']),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Error'),
            content: Text(responseData['message']),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred while submitting the response.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchLeaveRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink.shade900,
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
            return RequestScreen();
          }));
        },
        child: Center(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        backgroundColor: Colors.pink.shade900,
        title: apBarText('Leave Requests', Colors.white),
      ),
      body: leaveRequests.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: leaveRequests.length,
              itemBuilder: (ctx, index) {
                final leaveRequest = leaveRequests[index];
                return Card(
                  elevation: 4,
                  shadowColor: Colors.black12,
                  child: ListTile(
                    title: Text(
                      leaveRequest.reason,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Leave Date: ${leaveRequest.leaveDate}'),
                    trailing: Text(
                      leaveRequest.status,
                      style: TextStyle(
                        color: leaveRequest.status == 'accepted'
                            ? Colors.green
                            : leaveRequest.status == 'rejected'
                                ? Colors.red
                                : Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text('Leave Request Details'),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Reason: ${leaveRequest.reason}'),
                              Text('Leave Date: ${leaveRequest.leaveDate}'),
                              Text('To Date: ${leaveRequest.toDate}'),
                              Text('To Time: ${leaveRequest.toTime}'),
                              SizedBox(height: 16.0),
                              Text('Status: ${leaveRequest.status}'),
                              if (leaveRequest.status != 'pending')
                                Text('Comment: ${leaveRequest.comment}'),
                              SizedBox(height: 16.0),
                              if (leaveRequest.status == 'pending') ...[
                                Text('Respond to Request:'),
                                SizedBox(height: 8.0),
                                ElevatedButton(
                                  child: Text('Accept'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: Text('Respond to Leave Request'),
                                        content: TextFormField(
                                          decoration: InputDecoration(
                                              labelText: 'Comment'),
                                          onChanged: (value) {
                                            leaveRequest.comment = value;
                                          },
                                        ),
                                        actions: [
                                          TextButton(
                                            child: Text('Cancel'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          ElevatedButton(
                                            child: Text('Accept'),
                                            onPressed: () {
                                              respondToLeaveRequest(
                                                  leaveRequest,
                                                  'accepted',
                                                  leaveRequest.comment);
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: 8.0),
                                ElevatedButton(
                                  child: Text('Reject'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: Text('Respond to Leave Request'),
                                        content: TextFormField(
                                          decoration: InputDecoration(
                                              labelText: 'Comment'),
                                          onChanged: (value) {
                                            leaveRequest.comment = value;
                                          },
                                        ),
                                        actions: [
                                          TextButton(
                                            child: Text('Cancel'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          ElevatedButton(
                                            child: Text('Reject'),
                                            onPressed: () {
                                              respondToLeaveRequest(
                                                  leaveRequest,
                                                  'rejected',
                                                  leaveRequest.comment);
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ],
                          ),
                          actions: [
                            TextButton(
                              child: Text('Close'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
