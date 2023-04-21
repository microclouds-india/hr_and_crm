import 'package:flutter/material.dart';
import 'package:hr_and_crm/ui/addBiometric/addBiometric.dart';
import 'package:hr_and_crm/ui/addBranches/addBranchesScreen.dart';
import 'package:hr_and_crm/ui/attendance/attendancePage.dart';
import 'package:hr_and_crm/ui/branches/allBranches.dart';
import 'package:hr_and_crm/ui/branches/branches.dart';
import 'package:hr_and_crm/ui/employeeDetails/employeeDetailsPage.dart';
import 'package:hr_and_crm/ui/home/homeScreen.dart';
import 'package:hr_and_crm/ui/home/tabs/holidaysPage.dart';
import 'package:hr_and_crm/ui/home/tabs/leavePage.dart';
import 'package:hr_and_crm/ui/jobPost/jobPost.dart';
import 'package:hr_and_crm/ui/login/loginPage.dart';
import 'package:hr_and_crm/ui/qrCodePunchIn/qrCodePunchIn.dart';
import 'package:hr_and_crm/ui/signup/signupPage.dart';
import 'package:hr_and_crm/ui/splashscreen/splashScreen.dart';
import 'package:hr_and_crm/ui/template/templatePage.dart';

import '../ui/login Screens/numberScreen.dart';
import '../ui/leave request/leaveRequest.dart';
import '../ui/login/loginScreen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/splashScreen': (context) => const SplashScreen(),
  '/loginPage': (context) => const LoginPage(),
  '/signupPage': (context) => const SignupPage(),
  '/leavePage': (context) => const LeavePage(),
  '/attendancePage': (context) => const AttendancePage(),
  '/jobPost': (context) => const JobPost(),
  '/templatePage': (context) => const TemplatePage(),
  '/employeeDetailsPage': (context) => const EmployeeDetailsPage(),
  '/attendancePage': (context) => const AttendancePage(),
  '/leaveRequestPage': (context) =>  LeaveRequestScreen(),
  '/allBranches': (context) => const AllBranches(),
  '/Branches': (context) => const Branches(),
  '/addBranches': (context) => const AddBranches(),
  '/addBiometric': (context) => const AddBiometric(),
  '/qrCodePunchIn': (context) => const QrCodePunchIn(),
};
