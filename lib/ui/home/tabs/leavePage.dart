import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LeavePage extends StatelessWidget {
  const LeavePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        elevation: 0,
        title: Text(
          "Company Leaves",
          style: GoogleFonts.openSans(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink.shade900,
        elevation: 5.0,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed("/jobPost");
        },
      ),
      body: Column(
        children: [
          const SizedBox(height: 10.0),
          ListTile(
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: Colors.pink.shade900,
              ),
              child: const Center(
                child: Text(
                  "C",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            title: const Text("Casual Leave"),
            trailing: const Icon(Icons.more_vert),
          ),
          const SizedBox(height: 10.0),
          ListTile(
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: Colors.pink.shade900,
              ),
              child: const Center(
                child: Text(
                  "P",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            title: const Text("Privileged Leave"),
            trailing: const Icon(Icons.more_vert),
          ),
          const SizedBox(height: 10.0),
          ListTile(
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: Colors.pink.shade900,
              ),
              child: const Center(
                child: Text(
                  "S",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            title: const Text("Sick Leave"),
            trailing: const Icon(Icons.more_vert),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
