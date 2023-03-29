import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hr_and_crm/ui/leave%20request/reqestScreen.dart';

class LeaveRequestScreen extends StatefulWidget {
  const LeaveRequestScreen({super.key});

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
  @override
  Widget build(BuildContext context) {
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
      body: ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.pink.shade900,
              child: Center(
                child: Text(
                  '08',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                ),
              ),
            ),
            title: Text(
              'Reason of Leave',
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'date:01/02/03',
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
          );
        },
      ),
    );
  }
}
