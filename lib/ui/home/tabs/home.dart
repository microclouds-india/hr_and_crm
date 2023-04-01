import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_and_crm/repository/employees/notifier/employee.notifier.dart';
import 'package:hr_and_crm/ui/Company%20report/companyReport.dart';
import 'package:hr_and_crm/ui/Employees/Documents/documents.dart';
import 'package:hr_and_crm/ui/Employees/Documents/view_document.dart';
import 'package:hr_and_crm/ui/attendance/attendancePage.dart';
import 'package:hr_and_crm/ui/leave%20request/leaveRequest.dart';
import 'package:provider/provider.dart';

import '../../Employees/employees.dart';
import '../../Notes/reportScreen.dart';
import '../../Settings/settingsScreen.dart';
import 'holidaysPage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

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
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: GestureDetector(
                  onTap: () => _showMyDialog(),
                  child: Row(
                    children: const [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/icons/man.png'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Change Branch'),
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: const [
                    Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Log Out")
                  ],
                ),
              ),
            ],
            // offset: Offset(0, 60),
            color: Colors.white,
            elevation: 2,
            onSelected: (value) {
              if (value == 1) {
              } else if (value == 2) {
                print(value);
              }
            },
          ),
        ],
        backgroundColor: Colors.pink.shade900,
        elevation: 0,
        title: Text(
          "Home",
          style: GoogleFonts.openSans(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.pink.shade900,
              ),
              child: Center(
                child: Image.asset(
                  "assets/icons/logo.png",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: ListTile(
                leading: Icon(Icons.shopping_bag, color: Colors.pink.shade900),
                title: const Text('Leaves'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.pink.shade900,
                  size: 15,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return HolidaysPage();
              })),
              child: ListTile(
                leading:
                    Icon(Icons.calendar_month, color: Colors.pink.shade900),
                title: const Text('Holidays'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.pink.shade900,
                  size: 15,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed('/attendancePage'),
              child: ListTile(
                leading: Icon(Icons.verified_user_outlined,
                    color: Colors.pink.shade900),
                title: const Text('Attendance & Leaves'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.pink.shade900,
                  size: 15,
                ),
              ),
            ),
            // GestureDetector(
            //   onTap: () => Navigator.of(context)
            //       .push(MaterialPageRoute(builder: (context) {
            //     return EmployeesScreen();
            //   })),
            //   child: ListTile(
            //     leading: Icon(Icons.personal_injury_rounded,
            //         color: Colors.pink.shade900),
            //     title: const Text('Employees'),
            //     trailing: Icon(
            //       Icons.arrow_forward_ios,
            //       color: Colors.pink.shade900,
            //       size: 15,
            //     ),
            //   ),
            // ),
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return SettingsScreen();
              })),
              child: ListTile(
                leading: Icon(Icons.settings, color: Colors.pink.shade900),
                title: const Text('Settings'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.pink.shade900,
                  size: 15,
                ),
              ),
            ),
            // GestureDetector(
            //   onTap: () => Navigator.of(context)
            //       .push(MaterialPageRoute(builder: (context) {
            //     return DailyReportScreen();
            //   })),
            //   child: ListTile(
            //     leading: Icon(Icons.note_add, color: Colors.pink.shade900),
            //     title: const Text('Daily Report'),
            //     trailing: Icon(
            //       Icons.arrow_forward_ios,
            //       color: Colors.pink.shade900,
            //       size: 15,
            //     ),
            //   ),
            // ),
            // GestureDetector(
            //   onTap: () => Navigator.of(context)
            //       .push(MaterialPageRoute(builder: (context) {
            //     return EmployeeDocuments();
            //   })),
            //   child: ListTile(
            //     leading:
            //         Icon(Icons.document_scanner, color: Colors.pink.shade900),
            //     title: const Text('Documents'),
            //     trailing: Icon(
            //       Icons.arrow_forward_ios,
            //       color: Colors.pink.shade900,
            //       size: 15,
            //     ),
            //   ),
            // ),
            // GestureDetector(
            //   onTap: () {},
            //   child: ListTile(
            //     leading: Icon(Icons.person, color: Colors.pink.shade900),
            //     title: const Text('Profile'),
            //     trailing: Icon(
            //       Icons.arrow_forward_ios,
            //       color: Colors.pink.shade900,
            //       size: 15,
            //     ),
            //   ),
            // ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: ((context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title: const Text('Logout',
                          style: TextStyle(color: Colors.black)),
                      content: const Text(
                          'Do you want to logout from this account?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Text(
                            'No',
                            style: TextStyle(color: Colors.pink.shade900),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {},
                          child: Text(
                            'Yes',
                            style: TextStyle(color: Colors.pink.shade900),
                          ),
                        ),
                      ],
                    );
                  }),
                );
              },
              child: ListTile(
                leading: Icon(Icons.logout, color: Colors.pink.shade900),
                title: const Text('Logout'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.pink.shade900,
                  size: 15,
                ),
              ),
            ),
          ],
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
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return AttendancePage();
                })),
                child: homeContainer(
                    'assets/icons/checking-attendance.png', 'Attendance'),
              )),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return EmployeesScreen();
                  }));
                },
                child: homeContainer(
                    'assets/icons/business-people.png', 'Employees'),
              )),
              Expanded(
                  child: GestureDetector(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return EmployeeDocuments();
                })),
                child: homeContainer(
                    'assets/icons/documents-folder.png', 'Documents'),
              ))
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: GestureDetector(
                      onTap: () => Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return DailyReportScreen();
                          })),
                      child: homeContainer(
                          'assets/icons/report.png', 'Daily Repot'))),
              Expanded(
                  child: GestureDetector(
                      onTap: () => Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return LeaveRequestScreen();
                          })),
                      child: homeContainer(
                          'assets/icons/inbox.png', 'Leave Requests'))),
              Expanded(
                  child: GestureDetector(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return CompanyReportScreen();
                })),
                child: homeContainer(
                    'assets/icons/report (1).png', 'Company Report'),
              ))
            ],
          )
        ],
      ),
    );
  }

  Padding homeContainer(String img, String txt) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Spacer(),
              Center(
                  child: Image(
                height: 50,
                width: 50,
                image: AssetImage(img),
                fit: BoxFit.cover,
              )),
              Spacer(),
              Text(
                txt,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
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
                companyDetails(context, true),
                companyDetails(context, false),
                companyDetails(context, false)
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

  Column companyDetails(BuildContext context, bool itsCompany) {
    return Column(
      children: [
        Divider(
          thickness: 0.1,
          color: Colors.grey,
        ),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/icons/man.png'),
              ),
              Text(
                'Company name',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              // Visibility(
              //   visible: itsCompany,
              //   child: Icon(
              //     // IconData(0xe156, fontFamily: 'MaterialIcons'),
              //     Icon
              //     color: Colors.green,
              //   ),
              // )
            ],
          ),
        ),
        Divider(
          thickness: 0.1,
          color: Colors.grey,
        ),
      ],
    );
  }
}
