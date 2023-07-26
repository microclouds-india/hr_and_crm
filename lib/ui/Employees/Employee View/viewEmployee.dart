// ignore: file_names
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/Employee%20View/employeeViewMode.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../../common/widgets/appbarTXT.dart';

// ignore: must_be_immutable
class ViewEmployee extends StatefulWidget {
  String image;
  String username;
  String id;
  String jobrole;
  // ignore: use_key_in_widget_constructors
  ViewEmployee(
      {required this.id,
      required this.username,
      required this.jobrole,
      required this.image});

  @override
  State<ViewEmployee> createState() => _ViewEmployeeState();
}

class _ViewEmployeeState extends State<ViewEmployee> {
  String notImg =
      'https://us.123rf.com/450wm/pavelstasevich/pavelstasevich1811/pavelstasevich181101028/112815904-no-image-available-icon-flat-vector-illustration.jpg?ver=6';
  late EmployeeViewModel employeeViewModel;
  bool _loading = false;
  getEmployeeDetails() async {
    var url = Uri.parse('https://cashbes.com/attendance/apis/employee_view');
    var response = await http.post(url, body: {'id': widget.id});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      employeeViewModel = EmployeeViewModel.fromJson(json);
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
        title: apBarText(widget.username, Colors.white),
        centerTitle: true,
      ),
      body: _loading
          ? SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CachedNetworkImage(
  imageUrl: widget.image,
  imageBuilder: (context, imageProvider) => ClipRRect(
                      // ignore: sort_child_properties_last
                      child: Image(
                        image: imageProvider,
                        height: 170,
                        width: 170,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
  placeholder: (context, url) => CircularProgressIndicator(),
  errorWidget: (context, url, error) => Icon(Icons.error),
),
                  ),
                  const SizedBox(height: 16.0),
                  Center(
                    child: Text(
                      employeeViewModel.data![0].name ?? widget.username,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      widget.jobrole,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: Text(employeeViewModel.data![0].phone ?? ''),
                    onTap: () =>
                        // ignore: deprecated_member_use
                        launch('tel:${employeeViewModel.data![0].phone}'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: Text(employeeViewModel.data![0].email ?? ''),
                    onTap: () =>
                        // ignore: deprecated_member_use
                        launch('mailto:${employeeViewModel.data![0].email}'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.cake),
                    title: Text(employeeViewModel.data![0].dob ?? ''),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(employeeViewModel.data![0].gender ?? ''),
                  ),
                  ListTile(
                    leading: const Icon(Icons.location_on),
                    title: Text(employeeViewModel.data![0].address ?? ''),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.message),
                        // ignore: deprecated_member_use
                        onPressed: () => launch(
                            'https://wa.me/${employeeViewModel.data![0].phone}'),
                      ),
                      IconButton(
                        icon: const Icon(Icons.mail),
                        // ignore: deprecated_member_use
                        onPressed: () => launch(
                            'mailto:${employeeViewModel.data![0].email}'),
                      ),
                      IconButton(
                        icon: const Icon(Icons.phone),
                        onPressed: () =>
                            // ignore: deprecated_member_use
                            launch('tel:${employeeViewModel.data![0].phone}'),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                color: Colors.pink.shade900,
              ),
            ),
    );
  }
}
