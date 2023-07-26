import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/repository/Employee%20List/employeeListModel.dart';
import 'package:hr_and_crm/ui/Employees/searchEmployee.dart';
import 'package:hr_and_crm/ui/add%20Absent/add_absent.dart';
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
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return EmployeeSearchScreen();
                  }));
                },
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                )),
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
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return AddEmployeeScreen();
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
                    return Dismissible(
                      key: Key(employeesDetails.data![index].id
                          .toString()), // Set a unique key for each item
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        color: Colors.red,
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.endToStart) {
                          Ui.showAlertDialog(
                              context, 'Remove Employee', 'content', () async {
                            EasyLoading.show(status: 'Please Wait...');
                            var url = Uri.parse(
                                'https://cashbes.com/attendance/apis/employee_remove');
                            var reponse = await http.post(url,
                                body: {'id': employeesDetails.data![index].id});
                            if (reponse.statusCode == 200) {
                              print(reponse.body);
                              EasyLoading.dismiss();
                              Navigator.of(context).pop();
                              Ui.getSnackBar(
                                  title: 'Employee Removed', context: context);
                            } else {
                              EasyLoading.dismiss();
                              Navigator.of(context).pop();
                              Ui.getSnackBar(
                                  title: 'Server Error', context: context);
                            }
                          }, () {
                            Navigator.of(context).pop();
                          });
                        }
                      },
                      child: GestureDetector(
                        onTap: () => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ViewEmployee(
                            image:
                                employeesDetails.data![index].photo ?? notImg,
                            jobrole:
                                employeesDetails.data![index].jobrole ?? '',
                            username: employeesDetails.data![index].name!,
                            id: employeesDetails.data![index].id!,
                          );
                        })),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 4,
                          shadowColor: Colors.black87,
                          child: ListTile(
                            leading: CachedNetworkImage(
                                imageUrl: employeesDetails.data![index].photo ??
                                    notImg,
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage: imageProvider,
                                    ),
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.grey,
                                      child: Center(
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )),
                            title: Text(
                              employeesDetails.data![index].name ??
                                  'Name Not Available',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                                employeesDetails.data![index].jobrole ??
                                    'Jobrole Not Available'),
                            trailing: PopupMenuButton<String>(
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'absent',
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(Icons.leave_bags_at_home),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Absent'),
                                      ),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem<String>(
                                  value: '2',
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(Icons.delete,color: Colors.red,),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Delete'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              onSelected: (String value) {
                                if (value == 'absent') {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AddAbsentScreen(
                                      name: employeesDetails.data![index].name!,
                                      id: employeesDetails.data![index].id!,
                                    ),
                                  ));
                                } else if (value == 'Delete') {
                                  // Delete the item
                                  // Add your logic here to remove the item from the list or perform any other actions
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
