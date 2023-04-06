import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:hr_and_crm/repository/Employee%20View/employeeViewMode.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../../common/widgets/appbarTXT.dart';

class ViewEmployee extends StatefulWidget {
  String id;
  ViewEmployee({required this.id});

  @override
  State<ViewEmployee> createState() => _ViewEmployeeState();
}

class _ViewEmployeeState extends State<ViewEmployee> {
  String notImg =
      'https://us.123rf.com/450wm/pavelstasevich/pavelstasevich1811/pavelstasevich181101028/112815904-no-image-available-icon-flat-vector-illustration.jpg?ver=6';
  EmployeesViewModel employeesViewModel = EmployeesViewModel();
  bool _loading = false;
  getEmployeeDetails() async {
    var url = Uri.parse('https://cashbes.com/attendance/apis/employee_view');
    var response = await http.post(url, body: {'id': widget.id});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      employeesViewModel = EmployeesViewModel.fromJson(json);
      setState(() {
        _loading = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getEmployeeDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        title: apBarText('Username', Colors.white),
        centerTitle: true,
      ),
      body: _loading
          ? Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: SingleChildScrollView(
                child: Column(children: [
                  imageRow(employeesViewModel.data![0].photo ?? notImg),
                  const Divider(
                    thickness: 0.2,
                    color: Colors.grey,
                  ),
                  userDeatails('Employee ID', widget.id),
                  userDeatails(
                      'Phone', employeesViewModel.data![0].phone ?? ''),
                  userDeatails(
                      'Email', employeesViewModel.data![0].email ?? ''),
                  userDeatails('Birthday', '1995-12-19'),
                  userDeatails(
                      'Gender', employeesViewModel.data![0].gender ?? ''),
                  const ListTile(
                    title: Text(
                      'Address',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(employeesViewModel.data![0].address ?? ''),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: () async {
                              await launchUrl(Uri.parse(
                                  'https://wa.me/${employeesViewModel.data![0].phone}?text=Hello"'));
                            },
                            child: shareIMG('assets/icons/whatsapp.png')),
                        GestureDetector(
                            onTap: () {
                              final Uri _emailLaunchUri = Uri(
                                  scheme: 'mailto',
                                  path: employeesViewModel.data![0].email,
                                  queryParameters: {
                                    'subject':
                                        'Example Subject & Symbols are allowed!'
                                  });
                            },
                            child: shareIMG('assets/icons/gmail (1).png')),
                        GestureDetector(
                            onTap: () async {
                              const number =
                                  '08592119XXXX'; //set the number here
                              bool? res =
                                  await FlutterPhoneDirectCaller.callNumber(
                                      number);
                            },
                            child: shareIMG('assets/icons/phone-call.png'))
                      ],
                    ),
                  )
                ]),
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                color: Colors.pink.shade900,
              ),
            ),
    );
  }

  Image shareIMG(String img) {
    return Image(
      height: 20,
      width: 20,
      image: AssetImage(img),
      fit: BoxFit.cover,
    );
  }

  Column userDeatails(String tittle, String trailling) {
    return Column(
      children: [
        ListTile(
          title: Text(
            tittle,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          trailing: Text(
            trailling,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        const Divider(
          thickness: 0.1,
          color: Colors.grey,
        ),
      ],
    );
  }

  Column imageRow(String img) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  img,
                  height: 150.0,
                  width: 150.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        apBarText(employeesViewModel.data![0].name ?? 'Name Not Available',
            Colors.black),
        const SizedBox(
          height: 20,
        ),
        const Text('Web Developer')
      ],
    );
  }
}
