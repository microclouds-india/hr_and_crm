import 'package:flutter/material.dart';
import 'package:hr_and_crm/storage/storage.dart';

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
      LocalStorage localStorage = LocalStorage();
      await localStorage.getToken().then((value) {
        if (value != null) {
          Navigator.pushReplacementNamed(context, '/mainHomeView');
        } else {
          Navigator.pushReplacementNamed(context, '/loginPage');
        }
      });
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
