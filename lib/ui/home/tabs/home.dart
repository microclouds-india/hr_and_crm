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
          "Post a job",
          style: GoogleFonts.openSans(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
              child: Center(
                child: Row(
                  children: [
                    const Icon(Icons.edit_calendar, color: Colors.white),
                    const SizedBox(width: 5),
                    Text(
                      "Edit",
                      style: GoogleFonts.openSans(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  side: BorderSide(width: 1, color: Colors.pink.shade900),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed("/templatePage");
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Text(
                    'Ask staff to refer',
                    style: GoogleFonts.openSans(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              child: Container(
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.pink.shade900),
                height: kBottomNavigationBarHeight - 5,
                width: 150,
                child: Center(
                  child: Text(
                    "Share job poster",
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              onTap: () async {
                Navigator.of(context).pushNamed("/attendancePage");
              },
            ),
          ),
        ],
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
              onTap: () {},
              child: ListTile(
                leading: Icon(Icons.shopping_bag, color: Colors.pink.shade900),
                title: const Text('Leaves'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.pink.shade900,
                  size: 15,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: ListTile(
                leading:
                    Icon(Icons.calendar_month, color: Colors.pink.shade900),
                title: const Text('Holidays'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.pink.shade900,
                  size: 15,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: ListTile(
                leading: Icon(Icons.person, color: Colors.pink.shade900),
                title: const Text('Profile'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.pink.shade900,
                  size: 15,
                ),
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
                          onPressed: () async {},
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
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.pink.shade900,
                  size: 15,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Text("Review job details",
                style: GoogleFonts.openSans(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Container(
                width: 300,
                height: 400,
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 5.0,
                  child: Image.asset(
                    "assets/icons/logo.png",
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text("Select template",
                style: GoogleFonts.openSans(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              height: MediaQuery.of(context).size.height * 0.1,
              width: double.infinity,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    height: 90,
                    width: 90,
                    margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Image.asset(
                        "assets/icons/logo.png",
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
