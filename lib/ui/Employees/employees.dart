import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hr_and_crm/ui/Employees/Employee%20View/viewEmployee.dart';

import '../../common/widgets/appbarTXT.dart';
import 'Add Employees/addEmployee.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
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
                  return AddEmployeeScreen();
                }));
              } else if (value == 2) {
                print(value);
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) {
              return ViewEmployee();
            })),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.pink.shade900,
                backgroundImage: const AssetImage('assets/icons/man.png'),
              ),
              title: const Text(
                'Username',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Sales man'),
              trailing: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.more_horiz_sharp)),
            ),
          );
        },
      ),
    );
  }
}
