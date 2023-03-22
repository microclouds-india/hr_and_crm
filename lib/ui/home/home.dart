import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        elevation: 0,
        title: Text(
          "HR and CRM",
          style: GoogleFonts.openSans(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.pink.shade900,
              ),
              child: Center(
                child: Image.asset(
                  "assets/icons/logo.png",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {

              },
              child: ListTile(
                leading: Icon(Icons.shopping_bag, color: Colors.pink.shade900),
                title: const Text('Leaves'),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.pink.shade900, size: 15,),
              ),
            ),
            GestureDetector(
              onTap: () {

              },
              child: ListTile(
                leading: Icon(Icons.calendar_month, color: Colors.pink.shade900),
                title: const Text('Holidays'),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.pink.shade900, size: 15,),
              ),
            ),
            GestureDetector(
              onTap: () {

              },
              child: ListTile(
                leading: Icon(Icons.person, color: Colors.pink.shade900),
                title: const Text('Profile'),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.pink.shade900, size: 15,),
              ),
            ),
            GestureDetector(
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
                            style: TextStyle(color: Colors.pink.shade900),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {

                          },
                          child: Text(
                            'Yes',
                            style: TextStyle(color: Colors.pink.shade900),
                          ),
                        ),
                      ],
                    );
                  }),
                );
              },
              child: ListTile(
                leading: Icon(Icons.logout, color: Colors.pink.shade900),
                title: const Text('Logout'),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.pink.shade900, size: 15,),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: const [

          ],
        ),
      ),
    );
  }
}
