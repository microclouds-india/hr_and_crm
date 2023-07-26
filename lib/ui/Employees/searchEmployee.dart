import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/common/widgets/bookingFormTextFields.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EmployeeSearchScreen extends StatefulWidget {
  @override
  _EmployeeSearchScreenState createState() => _EmployeeSearchScreenState();
}

class _EmployeeSearchScreenState extends State<EmployeeSearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Employee> _employeeList = [];

  void searchEmployees(String searchTerm) async {
    var url = Uri.https('cashbes.com', '/attendance/apis/search');
    var headers = {"Content-Type": "application/x-www-form-urlencoded"};
    var body = {
      "start": "",
      "limit": "7",
      "title": searchTerm,
    };

    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data["status"] == "200") {
        List<dynamic> employees = data["data"];
        setState(() {
          _employeeList = employees.map((e) => Employee.fromJson(e)).toList();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {
          Navigator.of(context).pop();
        }),
        title: apBarText('Search Employee', Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                cursorColor: Colors.pink.shade900,
      decoration: new InputDecoration(
        border: new OutlineInputBorder(
          borderSide:
              new BorderSide(color: Colors.pink.shade900),
        ),
        focusedBorder: new OutlineInputBorder(
          borderSide:
              new BorderSide(color: Colors.pink.shade900),
        ),
        labelText: 'Search Employee..',
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        prefixIcon:  Icon(
       Icons.person ,
          color: Colors.pink.shade900,
        ),
      ),
                controller: _searchController,
                onChanged: (value) {
                  searchEmployees(value);
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _employeeList.length,
                itemBuilder: (BuildContext context, int index) {
                  var employee = _employeeList[index];
                  return Card(
                    
                    child: ListTile(
                      leading: CachedNetworkImage(
                        imageUrl: employee.photo,
                        imageBuilder: (context, imageProvider) => CircleAvatar(backgroundImage: imageProvider,),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => CircleAvatar(backgroundColor: Colors.grey,child: Center(
                          child: Icon(Icons.person,color: Colors.white,),
                        ),),
                      ),
                      title: Text(employee.name),
                      subtitle: Text(employee.jobRole),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Employee {
  final String id;
  final String companyId;
  final String name;
  final String dob;
  final String phone;
  final String city;
  final String email;
  final String address;
  final String jobRole;
  final String gender;
  final String photo;
  final String tDate;
  final String tTime;

  Employee({
    required this.id,
    required this.companyId,
    required this.name,
    required this.dob,
    required this.phone,
    required this.city,
    required this.email,
    required this.address,
    required this.jobRole,
    required this.gender,
    required this.photo,
    required this.tDate,
    required this.tTime,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      companyId: json['company_id'],
      name: json['name'],
      dob: json['dob'],
      phone: json['phone'],
      city: json['city'],
      email: json['email'],
      address: json['address'],
      jobRole: json['jobrole'],
      gender: json['gender'],
      photo: json['photo'],
      tDate: json['tdate'],
      tTime: json['ttime'],
    );
  }
}
