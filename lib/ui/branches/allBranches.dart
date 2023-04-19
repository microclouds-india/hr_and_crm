import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_and_crm/common/widgets/employeeContainer.dart';



class AllBranches extends StatefulWidget {
  const AllBranches({Key? key}) : super(key: key);

  @override
  State<AllBranches> createState() => _AllBranchesState();
}

class _AllBranchesState extends State<AllBranches> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.account_tree,
              color: Colors.black,
            ),
            Text(
              "All Branches",
              style: TextStyle(color: Colors.black),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
            ),
          ],
        ),
        leading: const Icon(
          Icons.arrow_back_ios_new_sharp,
          color: Colors.black,
        ),
        actions: [
          Row(
            children: const [
              Icon(
                Icons.arrow_drop_down_circle_outlined,
                color: Colors.blue,
              ),
              Text(
                "Daily Report",
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: const [
                  Icon(Icons.arrow_circle_left),
                  Spacer(),
                  Icon(Icons.calendar_month, color: Colors.blue),
                  Text("Wed,Mar 29"),
                  Spacer(),
                  Icon(Icons.arrow_circle_right),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 2,
              color: Colors.grey.shade200,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  PresentWidget(
                    Colors.green,
                    Colors.green.shade50,
                    "Present",
                    "7",
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  PresentWidget(
                    Colors.yellow.shade900,
                    Colors.yellow.shade50,
                    "Late",
                    "0",
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  PresentWidget(
                    Colors.red.shade900,
                    Colors.red.shade50,
                    "Absent",
                    "4",
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  PresentWidget(
                    Colors.orange.shade900,
                    Colors.orange.shade50,
                    "Half Day",
                    "0",
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  PresentWidget(
                    Colors.pink,
                    Colors.pink.shade50,
                    "Paid Leave",
                    "0",
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: double.infinity,
                height: 45,
                child: TextField(
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: "Search Employees",
                    prefixIcon: const Icon(Icons.search),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade200, width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  EmployeeContainer(name: "SHIVAPRIYA"),
                  const SizedBox(height: 5,),
                  EmployeeContainer(name: "SURESH KUMAR"),
                  const SizedBox(height: 5,),
                  EmployeeContainer(name: "VAISAKH"),
                ],

              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: kBottomNavigationBarHeight - 5,
        margin: const EdgeInsets.all(10.0),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
            side: BorderSide(width: 1, color: Colors.pink.shade900),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed("/Branches");
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Mark all absent as present',
              style: GoogleFonts.openSans(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}

Widget PresentWidget(
    Color sideColor,
    Color baseColor,
    String text,
    String num) {
  return Expanded(
    child: Row(
      children: [
        Container(
          height: 70,
          width: 2,
          color: sideColor,
        ),
        Expanded(
          child: Container(
            height: 70,
            width: 65,
            color: baseColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    num,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
