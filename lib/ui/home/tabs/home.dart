// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
// import 'package:hr_and_crm/provider/providers.dart';
// import 'package:hr_and_crm/repository/branches/notifier/branches.notifier.dart';
// import 'package:hr_and_crm/repository/employees/notifier/employee.notifier.dart';
// import 'package:hr_and_crm/ui/Company%20report/companyReport.dart';
// import 'package:hr_and_crm/ui/Employees/Documents/documents.dart';
// import 'package:hr_and_crm/ui/Salary%20calculator/salarycalculator.dart';
// import 'package:hr_and_crm/ui/Salary%20view/salary_view.dart';
// import 'package:hr_and_crm/ui/attendance/attendancePage.dart';
// import 'package:hr_and_crm/ui/attendance/viewAttendanceScreen.dart';
// import 'package:hr_and_crm/ui/leave%20request/leaveRequest.dart';
// import 'package:hr_and_crm/ui/video/video_confi.dart';
// import 'package:hr_and_crm/ui/work%20shift/work_shift_all.dart';
// import 'package:provider/provider.dart';
// import '../../Add account/addAccount.dart';
// import '../../Attendance management/attendance_management.dart';
// import '../../Employees/employees.dart';

// import '../../Expense Details/expenseDetais.dart';
// import '../../Notes/reportScreen.dart';
// import '../../branches/branches.dart';
// import '../../employee management/employeeManagement.dart';
// import '../../hr work reports/workReposts.dart';
// import '../../multi_login/multi_login.dart';
// import 'holidaysPage.dart';

// class Home extends StatefulWidget {
//   bool hr;
//   Home({required this.hr});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     print('000000000000000000000${widget.hr}');
//     final employeeData = Provider.of<EmployeeNotifier>(context, listen: false);
//     final branches = Provider.of<BranchesNotifier>(context, listen: false);
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.of(context)
//                     .push(MaterialPageRoute(builder: (context) {
//                   return Branches();
//                 }));
//               },
//               child: const Center(
//                 child: Text(
//                   "Branch Name",
//                   style: TextStyle(
//                       color: Colors.white, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               // child: Container(
//               //     width: 30.0,
//               //     height: 30.0,
//               //     decoration: const BoxDecoration(
//               //         shape: BoxShape.circle,
//               //         image: DecorationImage(
//               //             fit: BoxFit.fill,
//               //             image: AssetImage('assets/icons/man.png')))),
//             ),
//           ),
//         ],
//         backgroundColor: Colors.pink.shade900,
//         elevation: 0,
//         title: Text(
//           "Home",
//           style: GoogleFonts.openSans(
//               fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
//         ),
//       ),

//       // body: SingleChildScrollView(
//       //   scrollDirection: Axis.vertical,
//       //   physics: const BouncingScrollPhysics(),
//       //   child: Column(
//       //     children: [
//       //       FutureBuilder(
//       //         future: employeeData.getEmployees(),
//       //         builder: (context, snapshot) {
//       //           if (snapshot.hasData) {
//       //             return SizedBox(
//       //               height: MediaQuery.of(context).size.height,
//       //               width: MediaQuery.of(context).size.width,
//       //               child: GridView.builder(
//       //                   shrinkWrap: true,
//       //                   physics: const NeverScrollableScrollPhysics(),
//       //                   gridDelegate:
//       //                       const SliverGridDelegateWithFixedCrossAxisCount(
//       //                     crossAxisCount: 2,
//       //                   ),
//       //                   itemCount: employeeData.employeesModel.data.length,
//       //                   itemBuilder: (context, index) {
//       //                     return GestureDetector(
//       //                       onTap: () {
//       //                         employeeData.employeeId =
//       //                             employeeData.employeesModel.data[index].id;
//       //                         Navigator.of(context)
//       //                             .pushNamed("/employeeDetailsPage");
//       //                       },
//       //                       child: Container(
//       //                         margin: const EdgeInsets.all(10),
//       //                         decoration: BoxDecoration(
//       //                           color: Colors.white,
//       //                           borderRadius: BorderRadius.circular(20),
//       //                         ),
//       //                         child: Column(
//       //                           mainAxisAlignment: MainAxisAlignment.center,
//       //                           children: [
//       //                             Container(
//       //                               padding: const EdgeInsets.only(
//       //                                   left: 10, right: 10),
//       //                               height: 150,
//       //                               child: ClipRRect(
//       //                                 borderRadius: BorderRadius.circular(10),
//       //                                 child: CachedNetworkImage(
//       //                                   imageUrl: employeeData
//       //                                       .employeesModel.data[index].photo,
//       //                                   fit: BoxFit.cover,
//       //                                   errorWidget: ((context, url, error) {
//       //                                     return Image.asset(
//       //                                       "assets/icons/logo.png",
//       //                                       fit: BoxFit.cover,
//       //                                     );
//       //                                   }),
//       //                                   placeholder: (context, url) {
//       //                                     return Image.asset(
//       //                                       "assets/icons/logo.png",
//       //                                       fit: BoxFit.cover,
//       //                                     );
//       //                                   },
//       //                                 ),
//       //                               ),
//       //                             ),
//       //                             const SizedBox(
//       //                               height: 15,
//       //                             ),
//       //                             Text(
//       //                               employeeData
//       //                                   .employeesModel.data[index].name,
//       //                               style: GoogleFonts.montserrat(
//       //                                   fontSize: 16,
//       //                                   color: Colors.grey.shade700),
//       //                               overflow: TextOverflow.ellipsis,
//       //                               textAlign: TextAlign.center,
//       //                             ),
//       //                             Text(
//       //                               employeeData
//       //                                   .employeesModel.data[index].address,
//       //                               style: GoogleFonts.openSans(
//       //                                   fontSize: 16,
//       //                                   fontWeight: FontWeight.w600,
//       //                                   color: Colors.pink.shade900),
//       //                             ),
//       //                           ],
//       //                         ),
//       //                       ),
//       //                     );
//       //                   }),
//       //             );
//       //           }
//       //           return SizedBox(
//       //             height: MediaQuery.of(context).size.height,
//       //             child: Center(
//       //               child: CircularProgressIndicator(
//       //                 color: Colors.pink.shade900,
//       //               ),
//       //             ),
//       //           );
//       //         },
//       //       ),
//       //     ],
//       //   ),
//       // ),
//       body: Padding(
//         padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Expanded(
//                       child: Padding(
//                           padding: const EdgeInsets.all(5),
//                           child: GestureDetector(
//                             onTap: () {
//                               Navigator.of(context)
//                                   .push(MaterialPageRoute(builder: (context) {
//                                 return AttendanceManagement(
//                                   hr: widget.hr,
//                                 );
//                               }));
//                             },
//                             child: fancyContainer(
//                                 Colors.purple,
//                                 'assets/icons/checking-attendance.png',
//                                 widget.hr
//                                     ? 'Attendance Management'
//                                     : 'Attendance'),
//                           ))),
//                   Visibility(
//                     visible: widget.hr,
//                     child: Expanded(
//                         child: Padding(
//                       padding: const EdgeInsets.all(5),
//                       child: GestureDetector(
//                         onTap: () => Navigator.of(context)
//                             .push(MaterialPageRoute(builder: (context) {
//                           return const EmployeeManagement();
//                         })),
//                         child: fancyContainer(
//                             Colors.pink,
//                             'assets/icons/business-people.png',
//                             'Employyes Management'),
//                       ),
//                     )),
//                     replacement: Expanded(
//                         child: Padding(
//                       padding: const EdgeInsets.all(5),
//                       child: GestureDetector(
//                         onTap: () => Navigator.of(context)
//                             .push(MaterialPageRoute(builder: (context) {
//                           return DailyReportListScreen();
//                         })),
//                         child: fancyContainer(Colors.green,
//                             'assets/icons/report (1).png', 'Work Report'),
//                       ),
//                     )),
//                   )
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Expanded(
//                       child: Padding(
//                           padding: const EdgeInsets.all(5),
//                           child: GestureDetector(
//                             onTap: () => Navigator.of(context)
//                                 .push(MaterialPageRoute(builder: (context) {
//                               return HolidaysPage(
//                                 hr: widget.hr,
//                               );
//                             })),
//                             child: fancyContainer(Colors.lightBlue,
//                                 'assets/icons/calendar.png', 'Holiday'),
//                           ))),
//                   Visibility(
//                     visible: widget.hr,
//                     child: Expanded(
//                         child: Padding(
//                       padding: const EdgeInsets.all(5),
//                       child: GestureDetector(
//                         onTap: () => Navigator.of(context)
//                             .push(MaterialPageRoute(builder: (context) {
//                           return DailyReportListScreen();
//                         })),
//                         child: fancyContainer(Colors.green,
//                             'assets/icons/report (1).png', 'Daily Report'),
//                       ),
//                     )),
//                     replacement: Expanded(
//                       child: GestureDetector(
//                         onTap: () {
//                           if (widget.hr) {
//                             Navigator.of(context)
//                                 .push(MaterialPageRoute(builder: (context) {
//                               return LeaveRequestScreen();
//                             }));
//                           } else {
//                             Navigator.of(context)
//                                 .push(MaterialPageRoute(builder: (context) {
//                               return LeaveRequestScreen();
//                             }));
//                           }
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 5),
//                           child: fancyContainer(Colors.deepOrange,
//                               'assets/icons/inbox.png', 'Request Leave'),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               // Container(
//               //   height: 100,
//               //   width: MediaQuery.of(context).size.width,
//               //   decoration: BoxDecoration(
//               //       color: Color.fromARGB(59, 0, 0, 0),
//               //       borderRadius: BorderRadius.all(Radius.circular(20))),
//               // ),
//               // SizedBox(
//               //   height: 20,
//               // ),
//               Visibility(
//                 visible: widget.hr,
//                 child: GestureDetector(
//                   onTap: () => Navigator.of(context)
//                       .push(MaterialPageRoute(builder: (context) {
//                     return LeaveRequestScreen();
//                   })),
//                   child: listtileCotainer(context, Colors.lightBlue,
//                       'assets/icons/inbox.png', 'Leave Requestes'),
//                 ),
//               ),
//               Visibility(
//                 visible: widget.hr,
//                 child: GestureDetector(
//                   onTap: () => Navigator.of(context)
//                       .push(MaterialPageRoute(builder: (context) {
//                     return CompanyReportScreen();
//                   })),
//                   child: listtileCotainer(context, Colors.deepOrange,
//                       'assets/icons/report.png', 'Company Report'),
//                 ),
//               ),

//               Visibility(
//                 visible: widget.hr,
//                 child: GestureDetector(
//                   onTap: () => Navigator.of(context)
//                       .push(MaterialPageRoute(builder: (context) {
//                     return ExpenseDetailsScreen();
//                   })),
//                   child: listtileCotainer(context, Colors.limeAccent,
//                       'assets/icons/calculator.png', 'Expense Details'),
//                 ),
//               ),
//               Visibility(
//                   visible: widget.hr,
//                   child: GestureDetector(
//                     onTap: () => Navigator.of(context)
//                         .push(MaterialPageRoute(builder: (context) {
//                       return SalaryCalculator();
//                     })),
//                     child: listtileCotainer(context, Colors.black87,
//                         'assets/icons/calculator.png', 'Salary Calculator'),
//                   )),

//               widget.hr == false
//                   ? GestureDetector(
//                       onTap: () {
//                         Navigator.of(context)
//                             .push(MaterialPageRoute(builder: (context) {
//                           return SalaryViewScreen();
//                         }));
//                       },
//                       child: listtileCotainer(context, Colors.teal,
//                           'assets/icons/employee.png', "Salary Details"),
//                     )
//                   : SizedBox(),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.of(context)
//                       .push(MaterialPageRoute(builder: (context) {
//                     return WorkShiftAll();
//                   }));
//                 },
//                 child: listtileCotainer(context, Colors.blueAccent,
//                     'assets/icons/shift.png', 'Work Shift'),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Padding listtileCotainer(
//       BuildContext context, Color color, String img, String txt) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10, left: 6),
//       child: Container(
//           height: 50,
//           width: MediaQuery.of(context).size.width,
//           decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border(
//                 left: BorderSide(
//                   color: color,
//                   width: 3.0,
//                 ),
//               )),
//           child: Padding(
//             padding: const EdgeInsets.only(
//               left: 20,
//               right: 20,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Container(
//                   height: 30,
//                   width: 30,
//                   color: color.withOpacity(0.3),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Image(image: AssetImage(img)),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 20,
//                 ),
//                 Text(
//                   txt,
//                   style: TextStyle(
//                       color: Colors.black87, fontWeight: FontWeight.bold),
//                 )
//               ],
//             ),
//           )),
//     );
//   }

//   Container fancyContainer(Color color, String img, String txt) {
//     return Container(
//         height: 120,
//         width: 100,
//         decoration: BoxDecoration(
//             color: Colors.white,
//             border: Border(
//               left: BorderSide(
//                 color: color,
//                 width: 3.0,
//               ),
//             )),
//         child: Padding(
//           padding: const EdgeInsets.only(left: 10, right: 20, top: 10),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Container(
//                 height: 50,
//                 width: 50,
//                 color: color.withOpacity(0.3),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Image(image: AssetImage(img)),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 txt,
//                 style:
//                     TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
//               )
//             ],
//           ),
//         ));
//   }
// }

// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/clock_in/clock_in_notifier/clock_IN_notifier.dart';
import 'package:hr_and_crm/repository/clock_out/notifier/clock_OUT_notifier.dart';
import 'package:hr_and_crm/repository/clockin_view/notifier/notifier.dart';
import 'package:hr_and_crm/ui/Employees/Documents/documents.dart';
import 'package:hr_and_crm/ui/Leave%20typs/leaveTypes.dart';
import 'package:http/http.dart' as http;
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/ui/Attendance%20management/attendance_management.dart';
import 'package:hr_and_crm/ui/Company%20report/companyReport.dart';
import 'package:hr_and_crm/ui/Employees/employees.dart';
import 'package:hr_and_crm/ui/Expense%20Details/expenseDetais.dart';
import 'package:hr_and_crm/ui/Salary%20calculator/salarycalculator.dart';
import 'package:hr_and_crm/ui/Selfi%20attendance%20screen/selfiAttendance.dart';
import 'package:hr_and_crm/ui/biometric%20scanning/biomatricScreen.dart';
import 'package:hr_and_crm/ui/home/tabs/holidaysPage.dart';
import 'package:hr_and_crm/ui/hr%20work%20reports/workReposts.dart';
import 'package:hr_and_crm/ui/leave%20request/leaveRequest.dart';
import 'package:hr_and_crm/ui/qr%20code%20scan/qrcodeScreen.dart';
import 'package:hr_and_crm/ui/work%20shift/work_shift_all.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/ui.dart';
import '../../../repository/employee assigned workshift/notifier/notifier.dart';
import '../../attendance/viewAttendanceScreen.dart';
import '../../branches/branches.dart';
import '../../leave request/employeeLeaveRequests.dart';

class Home extends StatelessWidget {
  bool hr;
  Home({required this.hr});

  @override
  Widget build(BuildContext context){
    final clockInNotifier =
        Provider.of<ClockINNotifier>(context, listen: false);
    final clockOutNotifier =
        Provider.of<ClockOUTNotifier>(context, listen: false);
    final clockInView =
        Provider.of<ClockInViewNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Visibility(
            // visible: hr,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return Branches();
                  }));
                },
                child: Center(
                  child: Visibility(
                    visible: false,
                    child: Text(
                      "Branch Name",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                // child: Container(
                //     width: 30.0,
                //     height: 30.0,
                //     decoration: const BoxDecoration(
                //         shape: BoxShape.circle,
                //         image: DecorationImage(
                //             fit: BoxFit.fill,
                //             image: AssetImage('assets/icons/man.png')))),
              ),
            ),
          ),
        ],
        backgroundColor: Colors.pink.shade900,
        title: apBarText('Home', Colors.white),
        centerTitle: true,
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.pink.shade900,
              ),
              child: Column(
                children: [
                  Image(
                      height: 100,
                      width: 100,
                      image: AssetImage('assets/icons/logo.png'))
                ],
              ),
            ),
            Visibility(
              visible: hr,
              child: ListTile(
                leading: Icon(Icons.note),
                title: const Text('Employee Report'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return CompanyReportScreen();
                  }));
                },
              ),
              replacement: ListTile(
                leading: const Icon(Icons.leave_bags_at_home),
                title: const Text('Request Leave'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return EmployeeLeavRequests();
                  }));
                },
              ),
            ),
            Visibility(
              // visible: hr,
              child: ListTile(
                leading: Icon(Icons.money),
                title: const Text('Expense Details'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return ExpenseDetailsScreen(
                      hr: hr,
                    );
                  }));
                },
              ),
              replacement: ListTile(
                leading: Icon(Icons.transfer_within_a_station),
                title: const Text('Workshifts'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return WorkShiftAll(
                      hr: hr,
                    );
                  }));
                },
              ),
            ),
            Visibility(
              visible: hr,
              child: ListTile(
                leading: const Icon(Icons.calculate),
                title: const Text('Salary Calculator'),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return SalaryCalculator();
                  }));
                },
              ),
              replacement: ListTile(
                leading: const Icon(Icons.history),
                title: const Text('Attendance History'),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
                onTap: () async {
                  final prif = await SharedPreferences.getInstance();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return ViewAttendance(
                      toke: prif.getString('token')!,
                    );
                  }));
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.notes),
              title: const Text('Work Report'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return DailyReportListScreen(
                    
                  );
                }));
                //  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                //    return EmployeesScreen();
                //  }));
              },
            ),
            ListTile(
              leading: const Icon(Icons.file_copy_sharp),
              title: const Text('Documents'),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return EmployeeDocuments();
                }));
                //  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                //    return EmployeesScreen();
                //  }));
              },
            ),
            Visibility(
              visible: hr,
              child: ListTile(
                leading: const Icon(Icons.leave_bags_at_home_outlined),
                title: const Text('Leave Types'),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return LeaveTypesScreen();
                  }));
                  //  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  //    return EmployeesScreen();
                  //  }));
                },
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: SingleChildScrollView(
          child: hr == true
              ? hrScreenUI(hr: hr,)
              : EmployeeUI(
                  ),
        ),
      ),
    );
  }


 



  

  Column attendanceType(IconData icon, String txt) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            height: 100,
            width: 100,
            color: Colors.white,
            child: Center(
              child: Icon(
                icon,
                size: 50,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(txt)
      ],
    );
  }

  Container activityContainer() {
    return Container(
      height: 130,
      width: 120,
      child: Column(
        children: [
          Card(
              elevation: 4,
              shadowColor: Colors.black87,
              child: Container(
                height: 100,
                width: 100,
                child: Center(
                  child: Icon(Icons.abc),
                ),
              )),
          Text('Attendance All')
        ],
      ),
    );
  }

  Card entryDetails(String txt, String value, Color txtColor) {
    return Card(
      color: txtColor,
      elevation: 4,
      shadowColor: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              txt,
              style: TextStyle(color: Colors.black),
            ),
            Text(
              value,
              style: TextStyle(color: Colors.black45),
            )
          ],
        ),
      ),
    );
  }
}

GestureDetector hrCard(String txt, VoidCallback onTap, String img) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4,
      shadowColor: Colors.black87,
      child: Container(
        height: 150,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image(
              height: 50,
              width: 50,
              image: AssetImage(img),
              fit: BoxFit.cover,
            ),
            Text(txt),
          ],
        ),
      ),
    ),
  );
}








class hrScreenUI extends StatefulWidget {
  bool hr;
  hrScreenUI({required this.hr});

  @override
  State<hrScreenUI> createState() => _hrScreenUIState();
}

class _hrScreenUIState extends State<hrScreenUI> {
  @override
  Widget build(BuildContext context) {
    final clockInViewNotifier = Provider.of<ClockInViewNotifier>(context,listen: false);
    final clockINNotifier = Provider.of<ClockINNotifier>(context,listen: false);
    final clockOUTNotifier=  Provider.of<ClockOUTNotifier>(context,listen: false);
    return SingleChildScrollView(
      child: Column(
        children: [
          // Card(
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(10.0),
          //   ),
          //   elevation: 4,
          //   shadowColor: Colors.black87,
          //   child: Container(
          //     height: 140,
          //     width: double.infinity,
          //     decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.all(Radius.circular(20))),
          //     child: Padding(
          //       padding: const EdgeInsets.all(10),
          //       child: Column(
          //         children: [
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text(
          //                 'Last Attendance',
          //                 style: TextStyle(
          //                     color: Colors.black87,
          //                     fontWeight: FontWeight.bold,
          //                     fontSize: 16),
          //               ),
          //               GestureDetector(
          //                 onTap: ()async{
          //                  final prif = await SharedPreferences.getInstance();
          //                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
          //                   return ViewAttendance(toke: prif.getString('token').toString());
          //                  }));
          //                 },
          //                 child: Text(
          //                   'Wiew All',
          //                   style: TextStyle(
          //                       color: Colors.pink.shade900, fontSize: 16),
          //                 ),
          //               )
          //             ],
          //           ),
          //           SizedBox(
          //             height: 20,
          //           ),
                    
          //           Spacer(),
          //           Row(
          //             children: [
          //               CircleAvatar(
          //                   radius: 30,
          //                   backgroundImage: NetworkImage(
          //                       'https://upload.wikimedia.org/wikipedia/commons/b/b4/Lionel-Messi-Argentina-2022-FIFA-World-Cup_%28cropped%29.jpg')),
          //               Expanded(
          //                   child: ListTile(
          //                 title: Text(
          //                   'employee name',
          //                   style: TextStyle(
          //                       color: Colors.black87,
          //                       fontWeight: FontWeight.bold),
          //                 ),
          //                 subtitle: Text('Job role'),
          //               ))
          //             ],
          //           ),
          //           Spacer()
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
           FutureBuilder(
          future: clockInViewNotifier.fetchData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    color: Colors.pink.shade900,
                  ),
                ),
              );
            } else if (!snapshot.hasData) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 4,
                shadowColor: Colors.black87,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat('EEEE').format(DateTime.now()),
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            const Text(
                              '10 Dec 2023',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )
                          ],
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            entryDetails('ENTRY', '00:00', Colors.green),
                            
                            entryDetails(
                                'WORK TIME', '00:00', Colors.lightBlue),
                            entryDetails('EXIT', '0:00', Colors.red)
                          ],
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                onTap: () async {
                                  try {
                                    final prif =
                                        await SharedPreferences.getInstance();
                                    clockINNotifier.clockIN('', '',
                                        prif.get('token').toString(), context);
                                        setState(() {
                                          
                                        });
                                  } catch (e) {}
                                },
                                child: Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: Colors.pink.shade900,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 10,
                                        bottom: 10),
                                    child: Center(
                                      child: Text(
                                        'Clock IN',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 35,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black87),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Center(
                                  child: Text('Clock OUT'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 4,
                shadowColor: Colors.black87,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat('EEEE').format(DateTime.now()),
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            Text(
                              DateFormat('dd MMM yyyy').format(DateTime.now()),
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )
                          ],
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            entryDetails(
                                'ENTRY',
                                snapshot.data!.data[0].clockIn.toString(),
                                Colors.green),
                            // entryDetails('TOTAL', '00:00', Colors.yellow),
                            entryDetails(
                                'WORK TIME',
                                snapshot.data!.data[0].workTime.toString(),
                                Colors.lightBlue),
                            entryDetails(
                                'EXIT',
                                snapshot.data!.data[0].clockOut.toString(),
                                Colors.red)
                          ],
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                onTap: () async {
                                  Ui.getSnackBar(
                                      title: 'Already attendance marked!',
                                      context: context);
                                },
                                child: Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black87),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Center(
                                      child: Text('Clock In'),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                try {
                                 if (clockInViewNotifier.model.data[0].clockOut.isEmpty) {
                                    final prif =
                                      await SharedPreferences.getInstance();
                                      
                                  clockOUTNotifier.clockOut(
                                      token: prif.getString('token').toString(),
                                      clockin: '',
                                      id: snapshot.data!.data[0].id,
                                      clockOuttime: '',
                                      context: context,
                                      attendDate: '');
                                      setState(() {
                                        
                                      });
                                 }else{
                                  Ui.getSnackBar(title: 'Already attendance closed!', context: context);
                                 }
                                } catch (e) {
                                  print(e);
                                }
                              },
                              child: Container(
                                height: 35,
                                decoration: clockInViewNotifier
                                        .model.data[0].clockOut.isEmpty
                                    ? BoxDecoration(
                                        color: Colors.pink.shade900,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)))
                                    : BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black87),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: Center(
                                    child: Text(
                                      'Clock Out',
                                      style: TextStyle(
                                          color: clockInViewNotifier.model
                                                  .data[0].clockOut.isEmpty
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: clockInViewNotifier.model
                                                  .data[0].clockOut.isEmpty
                                              ? FontWeight.bold
                                              : FontWeight.normal),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          }),
          Row(
            children: [
              Expanded(
                  child: hrCard('Attendance', ()async{
                    // final prif = await SharedPreferences.getInstance();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return AttendanceManagement(hr:widget.hr,);
                }));
              }, 'assets/icons/immigration.png')),
              Expanded(
                  child: hrCard('Employee', () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return EmployeesScreen();
                }));
              }, 'assets/icons/employee.png'))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                  child: hrCard('Leave Requestes', () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return LeaveRequestScreen();
                }));
              }, 'assets/icons/leave.png')),
              Expanded(
                child: hrCard('Reports', () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return DailyReportListScreen(
                      
                    );
                  }));
                }, 'assets/icons/report.png'),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                  child: hrCard('Holidays', () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return HolidaysPage(
                    hr: widget.hr,
                  );
                }));
              }, 'assets/icons/calendar.png')),
              Expanded(
                child: hrCard('Workshift', () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return WorkShiftAll(
                      hr:widget.hr,
                    );
                  }));
                }, 'assets/icons/shift.png'),
              )
            ],
          ),
        ],
      ),
    );
  }
    Card entryDetails(String txt, String value, Color txtColor) {
    return Card(
      color: txtColor,
      elevation: 4,
      shadowColor: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              txt,
              style: TextStyle(color: Colors.black),
            ),
            Text(
              value,
              style: TextStyle(color: Colors.black45),
            )
          ],
        ),
      ),
    );
  }

}







class EmployeeUI extends StatefulWidget {
  const EmployeeUI({super.key});

  @override
  State<EmployeeUI> createState() => _EmployeeUIState();
}

class _EmployeeUIState extends State<EmployeeUI> {





  @override
  Widget build(BuildContext context) {
    final employeeWorkshifts = Provider.of<EmployeeAssignedWorkShiftNotier>(context,listen: false);
    final clockOUTNotifier = Provider.of<ClockOUTNotifier>(context,listen: false);
    final clockINNotifier = Provider.of<ClockINNotifier>(context,listen: false);
    final clockInViewNotifier = Provider.of<ClockInViewNotifier>(context,listen: false);
    return Column(children: [
      Row(
        children: [
          Text(
            'What\'s Up Today',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      SizedBox(
        height: 10,
      ),
      FutureBuilder(
          future: employeeWorkshifts.fecthData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(
                color: Colors.pink.shade900,
              );
            } else if (!snapshot.hasData) {
              return const SizedBox();
            } else if(snapshot.hasData) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 4,
                shadowColor: Colors.black87,
                child: Container(
                    height: 75,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        left: BorderSide(
                          color: Colors.green,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.calendar_today),
                      ),
                      title: Text(snapshot.data!.data[0].shift),
                      subtitle: Text('${snapshot.data!.data[0].startTime} to ${snapshot.data!.data[0].endTime}'),
                    )),
              );
           
          }else{
            return Center(child: SizedBox(),);
          }
          }),
      SizedBox(
        height: 10,
      ),
      FutureBuilder(
          future: clockInViewNotifier.fetchData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.pink.shade900,
                ),
              );
            } else if (!snapshot.hasData) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 4,
                shadowColor: Colors.black87,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat('EEEE').format(DateTime.now()),
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            const Text(
                              '10 Dec 2023',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )
                          ],
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            entryDetails('ENTRY', '00:00', Colors.green),
                            // entryDetails('TOTAL', '00:00', Colors.yellow),
                            entryDetails(
                                'WORK TIME', '00:00', Colors.lightBlue),
                            entryDetails('EXIT', '0:00', Colors.red)
                          ],
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                onTap: () async {
                                  try {
                                    final prif =
                                        await SharedPreferences.getInstance();
                                    clockINNotifier.clockIN('', '',
                                        prif.get('token').toString(), context);
                                        setState(() {
                                          
                                        });
                                  } catch (e) {}
                                },
                                child: Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: Colors.pink.shade900,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 10,
                                        bottom: 10),
                                    child: Center(
                                      child: Text(
                                        'Clock IN',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 35,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black87),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Center(
                                  child: Text('Clock OUT'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 4,
                shadowColor: Colors.black87,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat('EEEE').format(DateTime.now()),
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            Text(
                              DateFormat('dd MMM yyyy').format(DateTime.now()),
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )
                          ],
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            entryDetails(
                                'ENTRY',
                                snapshot.data!.data[0].clockIn.toString(),
                                Colors.green),
                            // entryDetails('TOTAL', '00:00', Colors.yellow),
                            entryDetails(
                                'WORK TIME',
                                snapshot.data!.data[0].workTime.toString(),
                                Colors.lightBlue),
                            entryDetails(
                                'EXIT',
                                snapshot.data!.data[0].clockOut.toString(),
                                Colors.red)
                          ],
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                onTap: () async {
                                  Ui.getSnackBar(
                                      title: 'Already attendance marked!',
                                      context: context);
                                },
                                child: Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black87),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Center(
                                      child: Text('Clock In'),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                try {
                                if (clockInViewNotifier.model.data[0].clockOut.isEmpty) {
                                  final prif =
                                      await SharedPreferences.getInstance();
                                  clockOUTNotifier.clockOut(
                                      token: prif.getString('token').toString(),
                                      clockin: '',
                                      id: snapshot.data!.data[0].id,
                                      clockOuttime: '',
                                      context: context,
                                      attendDate: '');
                                      setState(() {
                                        
                                      });
                                }else{
                                  Ui.getSnackBar(title: 'Already attendance closed!', context: context);
                                }
                                } catch (e) {
                                  print(e);
                                }
                              },
                              child: Container(
                                height: 35,
                                decoration: clockInViewNotifier
                                        .model.data[0].clockOut.isEmpty
                                    ? BoxDecoration(
                                        color: Colors.pink.shade900,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)))
                                    : BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black87),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: Center(
                                    child: Text(
                                      'Clock Out',
                                      style: TextStyle(
                                          color: clockInViewNotifier.model
                                                  .data[0].clockOut.isEmpty
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: clockInViewNotifier.model
                                                  .data[0].clockOut.isEmpty
                                              ? FontWeight.bold
                                              : FontWeight.normal),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          }),
      SizedBox(
        height: 10,
      ),
      Row(
        children: [
          Text(
            'Attendance Types',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return SelfieAttendanceScreen();
                }));
              },
              child: attendanceType(Icons.camera, 'Selfi')),
          GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return BiometricScreen();
                }));
              },
              child: attendanceType(Icons.fingerprint, 'Biomatric')),
          GestureDetector(
              onTap: () async {
                //     final prif = await SharedPreferences.getInstance();
                //     Navigator.of(context).push(MaterialPageRoute(builder: (context){
                //   return PunchInAttendance(token: prif.getString('token').toString());
                // }));
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return QrCodeScreen();
                }));
              },
              child: attendanceType(Icons.qr_code, 'QR')),
        ],
      ),
      SizedBox(
        height: 20,
      ),
      Row(
        children: [
          Text(
            'Last Work Reports',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      FutureBuilder(
          future: fetchLastReport(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(
                color: Colors.pink.shade900,
              );
            } else if (!snapshot.hasData) {
              return SizedBox();
            } else if (snapshot.data!['status']=='200') {
              final data = snapshot.data!['data'];
              final lastItem = data[data.length - 1];
              final reportMessage = lastItem['report_message'];
              final reportDate = lastItem['report_date'];
              print('Report Message: $reportMessage');
              print('Report Date: $reportDate');

              return Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Card(
                  elevation: 4,
                  shadowColor: Colors.black87,
                  child: Container(
                      height: 75,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            left: BorderSide(
                              color: Colors.green,
                              width: 3.0,
                            ),
                          )),
                      child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.calendar_today),
                        ),
                        title: Text(reportMessage),
                        subtitle: Text(reportDate),
                      )),
                ),
              );
            } else {
              
             return Center( child: Text('Data Not Availabe'),);
            }
          }),
    ]);
  }
    Future<Map<String, dynamic>> fetchLastReport() async {
    final prif = await SharedPreferences.getInstance();
    final url =
        Uri.parse('https://cashbes.com/attendance/apis/employee_work_reports');
    final response = await http.post(url, body: {
      'token': prif.getString('token'),
    });
    print(prif.getString('MyId'));

    if (response.statusCode == 200) {
      final parsedResponse = json.decode(response.body);
      return parsedResponse;
    } else {
      throw Exception('Failed to load data');
    }
  }


  Column attendanceType(IconData icon, String txt) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            height: 100,
            width: 100,
            color: Colors.white,
            child: Center(
              child: Icon(
                icon,
                size: 50,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(txt)
      ],
    );
  }

    Card entryDetails(String txt, String value, Color txtColor) {
    return Card(
      color: txtColor,
      elevation: 4,
      shadowColor: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              txt,
              style: TextStyle(color: Colors.black),
            ),
            Text(
              value,
              style: TextStyle(color: Colors.black45),
            )
          ],
        ),
      ),
    );
  }
}
