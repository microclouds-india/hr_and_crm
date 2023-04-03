import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/ui/Notes/viewreport.dart';
import 'package:hr_and_crm/ui/Notes/writeNoteScreen.dart.dart';

import 'editReport.dart';

class DailyReportScreen extends StatefulWidget {
  @override
  _DailyReportScreenState createState() => _DailyReportScreenState();
}

class _DailyReportScreenState extends State<DailyReportScreen>
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
        title: apBarText('Daily Reports', Colors.white),
        bottom: TabBar(
          indicatorColor: Colors.white,
          controller: _tabController,
          tabs: [
            Tab(text: 'Morning Reports'),
            Tab(text: 'Evening Reports'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [morningRepostScreen(), eveningRepostScreen()],
      ),
    );
  }

  Scaffold eveningRepostScreen() {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return WriteNoteScreen(
            morning: false,
          );
        })),
        backgroundColor: Colors.pink.shade900,
        child: Center(
          child: Icon(Icons.add),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) {
              return ViewDailyReport();
            })),
            child: ListTile(
              title: Text(
                'Text Evening Report',
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text('date${DateTime.now()}'),
              trailing: IconButton(
                  onPressed: () => Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return EditReportScreen();
                      })),
                  icon: Icon(
                    Icons.edit,
                    color: Colors.grey,
                  )),
            ),
          );
        },
      ),
    );
  }

  Scaffold morningRepostScreen() {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return WriteNoteScreen(
            morning: true,
          );
        })),
        backgroundColor: Colors.pink.shade900,
        child: Center(
          child: Icon(Icons.add),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) {
              return ViewDailyReport();
            })),
            child: ListTile(
              title: Text(
                'Text Morning Report',
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text('date${DateTime.now()}'),
              trailing: IconButton(
                  onPressed: () => Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return EditReportScreen();
                      })),
                  icon: Icon(
                    Icons.edit,
                    color: Colors.grey,
                  )),
            ),
          );
        },
      ),
    );
  }
}
