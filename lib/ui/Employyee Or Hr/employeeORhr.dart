import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/ui/login/loginPage.dart';

import '../../ui_employee/Employee login/employeeLoginScreen.dart';
import '../login Screens/numberScreen.dart';

class RolePage extends StatelessWidget {
  const RolePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image(
                height: 100,
                width: 100,
                image: AssetImage('assets/icons/logo.png'),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              'Select Your Role',
              style: TextStyle(
                  color: Colors.pink.shade900,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return NumberLogin();
              })),
              child: roleContaine(
                  context,
                  'HR manager',
                  'Register your company & start attendance',
                  'assets/icons/division.png'),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return EmployeeNumberLogin();
              })),
              child: roleContaine(
                  context,
                  'Employee',
                  'Register and start making your attendance',
                  'assets/icons/employee.png'),
            )
          ],
        ),
      ),
    );
  }

  Padding roleContaine(
      BuildContext context, String tittle, String subtittle, String icon) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: Colors.grey)),
        child: Center(
          child: ListTile(
            leading: Image(image: AssetImage(icon)),
            title: Text(
              tittle,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(subtittle),
          ),
        ),
      ),
    );
  }
}
