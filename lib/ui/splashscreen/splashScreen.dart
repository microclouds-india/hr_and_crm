import 'package:flutter/material.dart';
import 'package:hr_and_crm/storage/storage.dart';
import 'package:hr_and_crm/ui/home/homeScreen.dart';
import 'package:hr_and_crm/ui/home/tabs/home.dart';
import 'package:hr_and_crm/ui/login/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Employyee Or Hr/employeeORhr.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      final prif = await SharedPreferences.getInstance();
      if (prif.getString('token') == null || prif.getString('token')!.isEmpty) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return RolePage();
        }));
      } else {
        print('tokeeeeeeeeeeeeeeeeeeeen${prif.getString('token')}');
        bool hr = prif.get('HR') as bool;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomeScreen(hr: hr,);
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          "assets/icons/logo.png",
          height: 100,
        ),
      ),
    );
  }
}
