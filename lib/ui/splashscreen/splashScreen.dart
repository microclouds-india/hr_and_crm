import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/ui/home/homeScreen.dart';
import 'package:hr_and_crm/ui/login/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login Screens/numberScreen.dart';

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
      if (prif.getString('token') == null ||
          prif.getString('token')!.isEmpty && prif.getString('role') == null ||
          prif.getString('role')!.isEmpty) {
        // ignore: use_build_context_synchronously
        print('222222222222222222${prif.getString('token')}');
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const NumberLogin();
        }));
      } else {
        if (prif.getString('role')!.contains('hr') ||
            prif.getString('role')!.contains('manager') ||
            prif.getString('role')!.contains('Hr') ||
            prif.getString('role')!.contains('Manager')
            ) {
               print('hrrrrrrrrrrrrrr${prif.getString('token')}');
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return HomeScreen(
              hr: true,
            );
          }));
        } else if (prif.getString('role')!.contains('Employee') || prif.getString('role')!.contains('employee')) {
          // ignore: use_build_context_synchronously
           print('emploeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee${prif.getString('token')}');
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return HomeScreen(
              hr: false,
            );
          }));
        } else {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const NumberLogin();
          }));
          // ignore: use_build_context_synchronously
          Ui.getSnackBar(title: 'Plese login!', context: context);
        }
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
