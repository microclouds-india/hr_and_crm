import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/ui/Chat%20Screen/chatScreen.dart';
import 'package:hr_and_crm/ui/home/tabs/holidaysPage.dart';
import 'package:hr_and_crm/ui/home/tabs/home.dart';
import 'package:hr_and_crm/ui/home/tabs/profilePage.dart';
import 'package:hr_and_crm/ui/jobPost/jobPost.dart';

class HomeScreen extends StatefulWidget {
  bool hr;
  HomeScreen({required this.hr});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List screens = [
      Home(hr: widget.hr),
      const ChatScreen(),
      widget.hr ? JobPost() : HolidaysPage(),
      const ProfilePage(),
    ];
    return WillPopScope(
      onWillPop: () {
        showDialog(
            context: context,
            builder: ((context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: const Text('Exit'),
                content: const Text('Do you want to exit from this app?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(
                      'No',
                      style: GoogleFonts.openSans(
                          fontSize: 15,
                          color: Colors.pink.shade900,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                    },
                    child: Text(
                      'Yes',
                      style: GoogleFonts.openSans(
                          fontSize: 15,
                          color: Colors.pink.shade900,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              );
            }));
        return Future.value(false);
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _selectedIndex,
          itemCornerRadius: 25,
          curve: Curves.easeIn,
          showElevation: false,
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
            // _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
          }),
          items: [
            BottomNavyBarItem(
              icon: const Icon(Icons.home),
              title: const Text('Home'),
              activeColor: Colors.pink.shade900,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.chat),
              title: const Text('Chat'),
              activeColor: Colors.pink.shade900,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(widget.hr ? Icons.chair_alt : Icons.calendar_month),
              title: Text(widget.hr ? 'Hire Staff' : 'Holidays'),
              activeColor: Colors.pink.shade900,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.person),
              title: const Text('Profile'),
              activeColor: Colors.pink.shade900,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        body: screens[_selectedIndex],
      ),
    );
  }
}
