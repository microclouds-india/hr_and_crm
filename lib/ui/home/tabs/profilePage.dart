import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_and_crm/repository/Profile%20View%20Model/profileViewModel.dart';
import 'package:http/http.dart' as http;
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/ui/Settings/settingsScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileViewMode profileViewMode = ProfileViewMode();
  bool _load = false;
  getProfileDate() async {
    final prif = await SharedPreferences.getInstance();
    var url = Uri.parse('https://cashbes.com/attendance/apis/my_profile');
    var response = await http.post(url, body: {
      'token': prif.getString('token'),
    });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      profileViewMode = ProfileViewMode.fromJson(json);
      setState(() {
        _load = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getProfileDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const SettingsScreen();
                  })),
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ))
        ],
        backgroundColor: Colors.pink.shade900,
        elevation: 0,
        title: Text(
          "Profile",
          style: GoogleFonts.openSans(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: _load
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Center(
                    child: Image.asset(
                      "assets/icons/logo.png",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(left: 15, right: 15, top: 30),
                    decoration: Ui.getBoxDecorationWithoutBorder(),
                    child: Column(
                      children: [
                         UserInfo(
                          title: "Name",
                          text: profileViewMode.data![0].name??'',
                          icon: Icons.person,
                        ),
                         UserInfo(
                          title: "Email",
                          text: profileViewMode.data![0].email??'',
                          icon: Icons.description,
                        ),
                        const UserInfo(
                          title: "Address",
                          text: "address" ?? "",
                          icon: Icons.location_on,
                        ),
                         UserInfo(
                          title: "Phone",
                          text: profileViewMode.data![0].phone??'',
                          icon: Icons.call,
                        ),
                        GestureDetector(
                          child: Container(
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                color: Colors.pink.shade900,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            height: 40,
                            width: 150,
                            child: Center(
                              child: Text(
                                "Logout",
                                style: GoogleFonts.openSans(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
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
                                        style: TextStyle(
                                            color: Colors.pink.shade900),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async {},
                                      child: Text(
                                        'Yes',
                                        style: TextStyle(
                                            color: Colors.pink.shade900),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            );
                          },
                        ),
                      ],
                    ),
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

class UserInfo extends StatelessWidget {
  const UserInfo({
    Key? key,
    required this.text,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final String title;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      padding: const EdgeInsets.all(20),
      decoration: Ui.getBoxDecorationWithoutBorder(),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.pink.shade900,
            size: 30,
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w700, fontSize: 14),
              ),
              SizedBox(
                width: 250,
                child: Text(
                  text,
                  style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w500, fontSize: 12),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
