import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_and_crm/repository/Profile%20View%20Model/profileViewModel.dart';
import 'package:hr_and_crm/ui/editProfile/editProfileScreen.dart';
import 'package:http/http.dart' as http;
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/ui/Settings/settingsScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../login Screens/numberScreen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileViewMode profileViewMode;
  Future<ProfileViewMode> getProfileDate() async {
    try {
      final prif = await SharedPreferences.getInstance();
      var url = Uri.parse('https://cashbes.com/attendance/apis/my_profile');
      var response = await http.post(url, body: {
        'token': prif.getString('token'),
      });
      if (response.statusCode == 200) {
        print(response.body);
        var json = jsonDecode(response.body);
        profileViewMode = ProfileViewMode.fromJson(json);
      }
    } catch (e) {
      Ui.getSnackBar(title: 'Server Error', context: context);
    }
    return profileViewMode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return EditProfileScreen(
                        address: profileViewMode.data[0].address,
                        city: profileViewMode.data[0].city,
                        dob: profileViewMode.data[0].dob,
                        email: profileViewMode.data[0].email,
                        gender: profileViewMode.data[0].gender,
                        imageUrl: profileViewMode.data[0].photo,
                        name: profileViewMode.data[0].name,
                        phone: profileViewMode.data[0].phone,
                      );
                    })),
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                )),
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
        body: FutureBuilder(
          future: getProfileDate(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: Colors.pink.shade900),
              );
            } else if (!snapshot.hasData) {
              return Center(
                child: Text('Empty...'),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    profileViewMode.data[0].photo == ''
                        ? Center(
                            child: Image.network(
                              'https://t4.ftcdn.net/jpg/04/99/93/31/360_F_499933117_ZAUBfv3P1HEOsZDrnkbNCt4jc3AodArl.jpg',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Center(
                            child: CachedNetworkImage(
                              imageUrl: snapshot.data!.data[0].photo.toString(),
                              imageBuilder: (context, imageProvider) =>
                                  ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                child: Image(
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                    image: imageProvider),
                              ),
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin:
                          const EdgeInsets.only(left: 15, right: 15, top: 30),
                      decoration: Ui.getBoxDecorationWithoutBorder(),
                      child: Column(
                        children: [
                          UserInfo(
                            title: "Name",
                            text: profileViewMode.data[0].name,
                            icon: Icons.person,
                          ),
                          UserInfo(text: profileViewMode.data[0].jobrole, title: 'Jobrole', icon: Icons.work),
                          UserInfo(
                            title: "Email",
                            text: profileViewMode.data[0].email,
                            icon: Icons.description,
                          ),
                          UserInfo(
                            title: "Address",
                            text: profileViewMode.data[0].address,
                            icon: Icons.location_on,
                          ),
                          UserInfo(
                            title: "Phone",
                            text: profileViewMode.data[0].phone,
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
                                        onPressed: () async {
                                          await EasyLoading.show(
                                              status: 'Plase Wait....');
                                          final prif = await SharedPreferences
                                              .getInstance();
                                          var url = Uri.parse(
                                              'https://cashbes.com/attendance/login/logout');
                                          var response =
                                              await http.post(url, body: {
                                            'token': prif.getString('token'),
                                          });
                                          print(response.body);
                                          await prif.remove('token');
                                          await prif.remove('role');
                                          EasyLoading.dismiss();
                                          mobileNumberController.clear();
                                          // ignore: use_build_context_synchronously
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                            return NumberLogin();
                                          }), (route) => false);
                                        },
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
              );
            }
          },
        ));
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
