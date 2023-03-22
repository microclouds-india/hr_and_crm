import 'package:flutter/material.dart';
import 'package:hr_and_crm/ui/home/homeScreen.dart';
import 'package:hr_and_crm/ui/login/loginPage.dart';
import 'package:hr_and_crm/ui/signup/signupPage.dart';
import 'package:hr_and_crm/ui/splashscreen/splashScreen.dart';

Map<String, Widget Function(BuildContext)> routes = {

  '/splashScreen': (context) => const SplashScreen(),
  '/loginPage': (context) => const LoginPage(),
  '/signupPage': (context) => const SignupPage(),
  '/homePage': (context) => const HomeScreen(),

};
