import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_and_crm/repository/employees/notifier/employee.notifier.dart';
import 'package:provider/provider.dart';

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
              onTap: () {},
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
                title: const Text('Attendance'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.pink.shade900,
                  size: 15,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: ListTile(
                leading: Icon(Icons.person, color: Colors.pink.shade900),
                title: const Text('Profile'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.pink.shade900,
                  size: 15,
                ),
              ),
            ),
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            FutureBuilder(
              future: employeeData.getEmployees(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: employeeData.employeesModel.data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              employeeData.employeeId =
                                  employeeData.employeesModel.data[index].id;
                              Navigator.of(context)
                                  .pushNamed("/employeeDetailsPage");
                            },
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    height: 150,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: employeeData
                                            .employeesModel.data[index].photo,
                                        fit: BoxFit.cover,
                                        errorWidget: ((context, url, error) {
                                          return Image.asset(
                                            "assets/icons/logo.png",
                                            fit: BoxFit.cover,
                                          );
                                        }),
                                        placeholder: (context, url) {
                                          return Image.asset(
                                            "assets/icons/logo.png",
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    employeeData
                                        .employeesModel.data[index].name,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        color: Colors.grey.shade700),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    employeeData
                                        .employeesModel.data[index].address,
                                    style: GoogleFonts.openSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.pink.shade900),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                }
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.pink.shade900,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
