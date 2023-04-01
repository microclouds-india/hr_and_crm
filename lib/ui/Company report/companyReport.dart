import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/ui/Company%20report/Notes/notes.dart';

import 'Attendance Report/attendanceSummaryReport.dart';

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
          tabs: [
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
              children: [Text('No Downloads')],
            ),
          )
        ],
      ),
    );
  }

  Padding reports() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          GestureDetector(
              onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return AttendanceSummaryReport();
                  })),
              child: repostList('Attendance', Icon(Icons.task_outlined))),
          repostList('Salary', Icon(Icons.money)),
          GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return CompanyNotesScreen();
                }));
              },
              child: repostList('Notes', Icon(Icons.notes))),
        ],
      ),
    );
  }

  ListTile repostList(String txt, Icon icon) {
    return ListTile(
      leading: icon,
      title: Text(txt),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey,
      ),
    );
  }
}
