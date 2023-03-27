import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_and_crm/repository/employeeDetails/notifier/employeeDetails.notifier.dart';
import 'package:hr_and_crm/repository/employees/notifier/employee.notifier.dart';
import 'package:provider/provider.dart';

class EmployeeDetailsPage extends StatelessWidget {
  const EmployeeDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final employeeDetails = Provider.of<EmployeeDetailsNotifier>(context, listen: false);
    final employeeData = Provider.of<EmployeeNotifier>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        elevation: 0,
        title: Text(
          "Home Details",
          style: GoogleFonts.openSans(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            FutureBuilder(
              future: employeeDetails.getEmployeeDetails(employeeId: employeeData.employeeId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: employeeDetails.employeesDetailsModel.data[0].photo,
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
                        Text(employeeDetails.employeesDetailsModel.data[0].name,
                          style: GoogleFonts.montserrat(
                              fontSize: 16, color: Colors.grey.shade700),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        Text(employeeDetails.employeesDetailsModel.data[0].address,
                          style: GoogleFonts.openSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.pink.shade900),
                        ),
                        Text(employeeDetails.employeesDetailsModel.data[0].email,
                          style: GoogleFonts.openSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.pink.shade900),
                        ),
                        Text(employeeDetails.employeesDetailsModel.data[0].phone,
                          style: GoogleFonts.openSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.pink.shade900),
                        ),
                        Text(employeeDetails.employeesDetailsModel.data[0].city,
                          style: GoogleFonts.openSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.pink.shade900),
                        ),
                      ],
                    ),
                  );
                }return SizedBox(
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
