import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/Employee%20List/employeeListModel.dart';
import 'package:hr_and_crm/repository/employeeDetails/model/employeeDetails.model.dart';
import 'package:http/http.dart' as http;
import 'package:hr_and_crm/ui/Employees/Employee%20View/viewEmployee.dart';

import '../../common/widgets/appbarTXT.dart';
import 'Add Employees/addEmployee.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  String notImg =
      'https://us.123rf.com/450wm/pavelstasevich/pavelstasevich1811/pavelstasevich181101028/112815904-no-image-available-icon-flat-vector-illustration.jpg?ver=6';
  EmployeesDetails employeesDetails = EmployeesDetails();
  late Stream<http.Response> _stream;

  @override
  void initState() {
    super.initState();
    _stream = http
        .get(Uri.parse('https://cashbes.com/attendance/apis/employees'))
        .asStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink.shade900,
          title: apBarText('Employees', Colors.white),
          centerTitle: true,
          actions: [
            PopupMenuButton<int>(
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.person_add,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Add Employee")
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.history,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("History")
                    ],
                  ),
                ),
              ],
              // offset: Offset(0, 60),
              color: Colors.white,
              elevation: 2,
              onSelected: (value) {
                if (value == 1) {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const AddEmployeeScreen();
                  }));
                } else if (value == 2) {}
              },
            ),
          ],
        ),
        body: StreamBuilder(
            stream: _stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var json = jsonDecode(snapshot.data!.body);
                employeesDetails = EmployeesDetails.fromJson(json);
                return ListView.builder(
                  itemCount: employeesDetails.data!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ViewEmployee(
                          id: employeesDetails.data![index].id!,
                        );
                      })),
                      child: ListTile(
                        leading: CircleAvatar(
                            backgroundColor: Colors.pink.shade900,
                            backgroundImage: NetworkImage(
                                employeesDetails.data![index].photo ?? notImg)),
                        title: Text(
                          employeesDetails.data![index].name ??
                              'Name Not Available',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Text('  '),
                        trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_horiz_sharp)),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
