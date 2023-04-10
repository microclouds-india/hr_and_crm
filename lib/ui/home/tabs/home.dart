import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/repository/employees/notifier/employee.notifier.dart';
import 'package:hr_and_crm/ui/Company%20report/companyReport.dart';
import 'package:hr_and_crm/ui/Employees/Documents/documents.dart';
import 'package:hr_and_crm/ui/attendance/attendancePage.dart';
import 'package:hr_and_crm/ui/attendance/viewAttendanceScreen.dart';
import 'package:hr_and_crm/ui/leave%20request/leaveRequest.dart';
import 'package:provider/provider.dart';
import '../../Add account/addAccount.dart';
import '../../Employees/employees.dart';

import '../../Expense Details/expenseDetais.dart';
import '../../Notes/reportScreen.dart';
import 'holidaysPage.dart';

class Home extends StatefulWidget {
  bool hr;
  Home({required this.hr});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final employeeData = Provider.of<EmployeeNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: _showMyDialog,
              child: Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/icons/man.png')))),
            ),
          ),
        ],
        backgroundColor: Colors.pink.shade900,
        elevation: 0,
        title: Text(
          "Home",
          style: GoogleFonts.openSans(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),

      // body: SingleChildScrollView(
      //   scrollDirection: Axis.vertical,
      //   physics: const BouncingScrollPhysics(),
      //   child: Column(
      //     children: [
      //       FutureBuilder(
      //         future: employeeData.getEmployees(),
      //         builder: (context, snapshot) {
      //           if (snapshot.hasData) {
      //             return SizedBox(
      //               height: MediaQuery.of(context).size.height,
      //               width: MediaQuery.of(context).size.width,
      //               child: GridView.builder(
      //                   shrinkWrap: true,
      //                   physics: const NeverScrollableScrollPhysics(),
      //                   gridDelegate:
      //                       const SliverGridDelegateWithFixedCrossAxisCount(
      //                     crossAxisCount: 2,
      //                   ),
      //                   itemCount: employeeData.employeesModel.data.length,
      //                   itemBuilder: (context, index) {
      //                     return GestureDetector(
      //                       onTap: () {
      //                         employeeData.employeeId =
      //                             employeeData.employeesModel.data[index].id;
      //                         Navigator.of(context)
      //                             .pushNamed("/employeeDetailsPage");
      //                       },
      //                       child: Container(
      //                         margin: const EdgeInsets.all(10),
      //                         decoration: BoxDecoration(
      //                           color: Colors.white,
      //                           borderRadius: BorderRadius.circular(20),
      //                         ),
      //                         child: Column(
      //                           mainAxisAlignment: MainAxisAlignment.center,
      //                           children: [
      //                             Container(
      //                               padding: const EdgeInsets.only(
      //                                   left: 10, right: 10),
      //                               height: 150,
      //                               child: ClipRRect(
      //                                 borderRadius: BorderRadius.circular(10),
      //                                 child: CachedNetworkImage(
      //                                   imageUrl: employeeData
      //                                       .employeesModel.data[index].photo,
      //                                   fit: BoxFit.cover,
      //                                   errorWidget: ((context, url, error) {
      //                                     return Image.asset(
      //                                       "assets/icons/logo.png",
      //                                       fit: BoxFit.cover,
      //                                     );
      //                                   }),
      //                                   placeholder: (context, url) {
      //                                     return Image.asset(
      //                                       "assets/icons/logo.png",
      //                                       fit: BoxFit.cover,
      //                                     );
      //                                   },
      //                                 ),
      //                               ),
      //                             ),
      //                             const SizedBox(
      //                               height: 15,
      //                             ),
      //                             Text(
      //                               employeeData
      //                                   .employeesModel.data[index].name,
      //                               style: GoogleFonts.montserrat(
      //                                   fontSize: 16,
      //                                   color: Colors.grey.shade700),
      //                               overflow: TextOverflow.ellipsis,
      //                               textAlign: TextAlign.center,
      //                             ),
      //                             Text(
      //                               employeeData
      //                                   .employeesModel.data[index].address,
      //                               style: GoogleFonts.openSans(
      //                                   fontSize: 16,
      //                                   fontWeight: FontWeight.w600,
      //                                   color: Colors.pink.shade900),
      //                             ),
      //                           ],
      //                         ),
      //                       ),
      //                     );
      //                   }),
      //             );
      //           }
      //           return SizedBox(
      //             height: MediaQuery.of(context).size.height,
      //             child: Center(
      //               child: CircularProgressIndicator(
      //                 color: Colors.pink.shade900,
      //               ),
      //             ),
      //           );
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: GestureDetector(
                            onTap: () {
                              if (widget.hr == true) {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return AttendancePage();
                                }));
                              } else {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return ViewAttendance();
                                }));
                              }
                            },
                            child: fancyContainer(
                                Colors.purple,
                                'assets/icons/checking-attendance.png',
                                'Attendance'),
                          ))),
                  Visibility(
                    visible: widget.hr,
                    child: Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return EmployeesScreen();
                        })),
                        child: fancyContainer(Colors.pink,
                            'assets/icons/business-people.png', 'Employyes'),
                      ),
                    )),
                    replacement: Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return DailyReportScreen();
                        })),
                        child: fancyContainer(Colors.green,
                            'assets/icons/report (1).png', 'Daily Report'),
                      ),
                    )),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: GestureDetector(
                            onTap: () => Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return HolidaysPage();
                            })),
                            child: fancyContainer(Colors.lightBlue,
                                'assets/icons/calendar.png', 'Holiday'),
                          ))),
                  Visibility(
                    visible: widget.hr,
                    child: Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return DailyReportScreen();
                        })),
                        child: fancyContainer(Colors.green,
                            'assets/icons/report (1).png', 'Daily Report'),
                      ),
                    )),
                    replacement: Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          //   return
                          // }))
                        },
                        child: fancyContainer(Colors.deepOrange,
                            'assets/icons/inbox.png', 'Request Leave'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              // Container(
              //   height: 100,
              //   width: MediaQuery.of(context).size.width,
              //   decoration: BoxDecoration(
              //       color: Color.fromARGB(59, 0, 0, 0),
              //       borderRadius: BorderRadius.all(Radius.circular(20))),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              Visibility(
                visible: widget.hr,
                child: GestureDetector(
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return LeaveRequestScreen();
                  })),
                  child: listtileCotainer(context, Colors.lightBlue,
                      'assets/icons/inbox.png', 'Leave Requestes'),
                ),
              ),
              Visibility(
                visible: widget.hr,
                child: GestureDetector(
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return CompanyReportScreen();
                  })),
                  child: listtileCotainer(context, Colors.deepOrange,
                      'assets/icons/report.png', 'Company Report'),
                ),
              ),
              Visibility(
                visible: widget.hr,
                child: GestureDetector(
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return ViewAttendance();
                  })),
                  child: listtileCotainer(
                      context,
                      Colors.green,
                      'assets/icons/checking-attendance.png',
                      'Attendance History'),
                ),
              ),
              Visibility(
                visible: widget.hr,
                child: GestureDetector(
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return EmployeeDocuments();
                  })),
                  child: listtileCotainer(context, Colors.purple,
                      'assets/icons/folders.png', 'Documents'),
                ),
              ),
              Visibility(
                visible: widget.hr,
                child: GestureDetector(
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return ExpenseDetailsScreen();
                  })),
                  child: listtileCotainer(context, Colors.limeAccent,
                      'assets/icons/calculator.png', 'Expense Details'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding listtileCotainer(
      BuildContext context, Color color, String img, String txt) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 6),
      child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                left: BorderSide(
                  color: color,
                  width: 3.0,
                ),
              )),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  color: color.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(image: AssetImage(img)),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  txt,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )
              ],
            ),
          )),
    );
  }

  Container fancyContainer(Color color, String img, String txt) {
    return Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              left: BorderSide(
                color: color,
                width: 3.0,
              ),
            )),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 20, top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 50,
                width: 50,
                color: color.withOpacity(0.3),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(image: AssetImage(img)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                txt,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ));
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('AlertDialog Title')),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Divider(
                  color: Colors.grey,
                  thickness: 0.2,
                ),
                ListTile(
                  leading: Container(
                      width: 48.0,
                      height: 48.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/icons/man.png')))),
                  title: Text(
                    'Branch name',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('abcdefg@gmail.com'),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return AddAccount();
                  })),
                  child: ListTile(
                    leading: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                    title: apBarText('Add Account', Colors.black),
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
