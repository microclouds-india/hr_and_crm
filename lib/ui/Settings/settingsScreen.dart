import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/Profile%20View%20Model/profileViewModel.dart';
import 'package:http/http.dart' as http;
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/ui/editProfile/editProfileScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _load = false;
  ProfileViewMode profileViewMode = ProfileViewMode();
  getProfileData() async {
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
    // TODO: implement initState
    super.initState();
    getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.quiz,
                  color: Colors.white,
                ),
                label: Text(
                  'Help',
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
        backgroundColor: Colors.pink.shade900,
        title: apBarText('Settings', Colors.white),
      ),
      body:_load? Column(
        children: [
          Container(
            color: Colors.white,
            child: ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/icons/man.png'),
              ),
              title:  Text(
                profileViewMode.data![0].name??'',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(profileViewMode.data![0].email??''),
              trailing: IconButton(
                  onPressed: () => Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return EditProfileScreen(email: profileViewMode.data![0].email??'',name: profileViewMode.data![0].name??'',phone: profileViewMode.data![0].phone??'',);
                      })),
                  icon: const Icon(Icons.edit)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ListTile(
              tileColor: Colors.white,
              leading: Icon(
                Icons.format_list_numbered,
                color: Colors.pink.shade900,
              ),
              title: Text(
                'Company Code:ABCD88',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Share this code with staff'),
              trailing: Container(
                height: 30,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.pink.shade900)),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.share,
                        color: Colors.pink.shade900,
                        size: 15,
                      ),
                      Text(
                        'Share',
                        style: TextStyle(
                            color: Colors.pink.shade900, fontSize: 15),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          settingsTile('VIP Membership',
              'Track daily staff attendance and more', Icons.workspace_premium),
          settingsTile(
              'User & Permissions', 'Staff & Managers', Icons.person),
          settingsTile('Attendance & Leaves',
              'Attendance Modes, Leaves ,Holidays', Icons.task),
          settingsTile('Salary Settings', 'Salary Settings', Icons.money)
        ],
      ):Center(
        child: CircularProgressIndicator(
          color: Colors.pink.shade900,
        ),
      ),
    );
  }

  Padding settingsTile(String tittle, String subtittle, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.pink.shade900,
        ),
        tileColor: Colors.white,
        subtitle: Text(
          subtittle,
          style: const TextStyle(overflow: TextOverflow.ellipsis),
        ),
        title: Text(
          tittle,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Icon(Icons.arrow_forward_ios_sharp),
      ),
    );
  }
}

Future<void> _showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Log Out'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Do you want to logout from this account?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'No',
              style: TextStyle(color: Colors.pink.shade900),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(
              'Yes',
              style: TextStyle(color: Colors.pink.shade900),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
