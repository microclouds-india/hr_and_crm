import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/ui/Company%20report/Employee/employeeReport.dart';
import 'package:hr_and_crm/ui/Company%20report/Late%20Arrival/lateArrivalScreen.dart';
import 'package:hr_and_crm/ui/Company%20report/Leave%20Report/leaveReport.dart';
import 'package:hr_and_crm/ui/Company%20report/Loan%20Report/loanReport.dart';
import 'package:hr_and_crm/ui/Company%20report/Notes/notes.dart';
import 'package:hr_and_crm/ui/Company%20report/Over%20time%20report/overtimeReport.dart';
import 'package:hr_and_crm/ui/Company%20report/Salary%20Datails%20Report/salaryDetaildReport.dart';
import 'package:hr_and_crm/ui/Company%20report/Salary%20summary%20report/salarySammaryReport.dart';

import 'Attendance Details Report/attendanceDetailsReportScreen.dart';
import 'Attendance Report/attendanceSummaryReport.dart';
import 'PF challan report/PFchallanReport.dart';

class CompanyReportScreen extends StatefulWidget {
  @override
  _CompanyReportScreenState createState() => _CompanyReportScreenState();
}

class _CompanyReportScreenState extends State<CompanyReportScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pink.shade900,
        title: apBarText('Company Report', Colors.white),
        bottom: TabBar(
          indicatorColor: Colors.white,
          controller: _tabController,
          tabs: const [
            Tab(text: 'REPORTS'),
            Tab(text: 'DOWNLOADS'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          reports(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [Text('No Downloads')],
            ),
          )
        ],
      ),
    );
  }

  Padding reports() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ExpansionTile(
              leading: const Icon(Icons.task_outlined),
              title: const Text('Attendance Report'),
              children: <Widget>[
                GestureDetector(
                    onTap: () => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const AttendanceSummaryReport();
                        })),
                    child: subList('Attendancce Summary Report')),
                GestureDetector(
                    onTap: () => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const AttendanceDetailedReport();
                        })),
                    child: subList('Attendance Detailed Report')),
                GestureDetector(
                    onTap: () => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const LateArrivalReport();
                        })),
                    child: subList('Late Arrival Report')),
                GestureDetector(
                    onTap: () => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const LeaveReport();
                        })),
                    child: subList('Leave Report')),
                GestureDetector(
                    onTap: () => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const OverTimeReport();
                        })),
                    child: subList('Over Time Report'))
              ],
            ),
            ExpansionTile(
              title: const Text('Salary'),
              leading: const Icon(Icons.money),
              children: <Widget>[
                GestureDetector(
                    onTap: () => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return SalarySummaryReport();
                        })),
                    child: subList('Salary Summary Report')),
                GestureDetector(
                    onTap: () => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return SalaryDetailedReport();
                        })),
                    child: subList('Salary Detailed Report')),
                GestureDetector(
                    onTap: () => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return PFchallanReport();
                        })),
                    child: subList('PF Challan Report')),
                GestureDetector(
                    onTap: () => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return LoanReport();
                        })),
                    child: subList('Loan Report'))
              ],
            ),
            GestureDetector(
                onTap: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const CompanyNotesScreen();
                    })),
                child: repostList('Notes', const Icon(Icons.notes))),
            GestureDetector(
                onTap: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const EmployeeReport();
                    })),
                child:
                    repostList('Employee', const Icon(Icons.person_2_rounded))),
          ],
        ),
      ),
    );
  }

  Column subList(String txt) {
    return Column(
      children: [
        Container(
          height: 20,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(txt),
          ),
        ),
        const Divider(
          thickness: 0.5,
          color: Colors.grey,
        )
      ],
    );
  }

  ListTile repostList(String txt, Icon icon) {
    return ListTile(
      leading: icon,
      title: Text(txt),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 15,
        weight: 20,
        color: Colors.grey,
      ),
    );
  }
}
