import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/repository/clock_out/notifier/clock_OUT_notifier.dart';
import 'package:hr_and_crm/repository/clockin_view/notifier/notifier.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repository/clock_in/clock_in_notifier/clock_IN_notifier.dart';

class BiometricScreen extends StatefulWidget {
  // bool attend;
  // BiometricScreen({required this.attend});

  @override
  State<BiometricScreen> createState() => _BiometricScreenState();
}

class _BiometricScreenState extends State<BiometricScreen> {
  final LocalAuthentication auth = LocalAuthentication();

  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  bool _isAuthenticating = false;
  String _authorized = 'Not Authorized';
  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate(ClockINNotifier notifier,ClockOUTNotifier clockOUTNotifier,bool authe,String id) async {
    final prif = await SharedPreferences.getInstance();
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Attendance';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Please be absent with your\nfingerint',
        options:
            const AuthenticationOptions(stickyAuth: true, biometricOnly: true),
      );

      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _authorized = authenticated ? 'Authorized' : 'Not Authorized';
    });
    if (authenticated == true) {
      final dateFormate = DateFormat("dd-MM-yyyy").format(DateTime.now());
      String _currentTime = DateFormat.Hm().format(DateTime.now());
      print('uuuuuuuuuuuuuuuuuuuuuuu${prif.getString('token')}');

     
     if (authe==true) {
        notifier.clockIN(dateFormate.toString(), _currentTime.toString(),
              prif.getString('token')!, context);
          prif.setBool('auth', notifier.isAttended = true);
     }else if (authe==false){
      clockOUTNotifier.clockOut(
        token: prif.getString('token').toString(),
        clockin: prif.getString('clockin_time')??'9:00',
            context: context,
              id: id,
              clockOuttime: '',
              attendDate: '');
          
     }
        
    }
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
  }

  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ClockINNotifier>(context, listen: false);
    final clockOut = Provider.of<ClockOUTNotifier>(context, listen: false);
    final clockInView = Provider.of<ClockInViewNotifier>(context,listen:false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
        child: Column(
          children: [
            const Spacer(),
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(40))),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Biometric Attendance',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Mark attendance by scanning the',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                    Center(
                      child: Text(
                        ' Fingerprint!',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Spacer(),
            const Image(
                height: 200,
                image: AssetImage('assets/icons/fingerprint-scan.gif')),
            const Spacer(),
            GestureDetector(
              onTap: ()async{
                clockInView.fetchData(context);
                late bool auth ;
                if (clockInView.model.data.isEmpty) {
                  auth = false;
                  _authenticate(data,clockOut,auth,clockInView.model.data[0].id);
                }else{
                  auth=true;
                  _authenticate(data,clockOut,auth,clockInView.model.data[0].id);
                }
                
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.pink.shade900,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: const Center(
                  child: Text(
                    'SCAN',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
