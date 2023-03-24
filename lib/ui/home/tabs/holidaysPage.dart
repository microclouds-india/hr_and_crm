import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HolidaysPage extends StatelessWidget {
  const HolidaysPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        elevation: 0,
        title: Text(
          "Holidays List",
          style: GoogleFonts.openSans(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {

            },
            child: Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white),
              child: Center(
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month, color: Colors.black),
                    const SizedBox(width: 5),
                    Text("2022",
                      style: GoogleFonts.openSans(
                          fontSize: 15, color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 5),
                    const Icon(Icons.arrow_drop_down, color: Colors.black),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GestureDetector(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.pink.shade900),
          height: kBottomNavigationBarHeight - 5,
          width: 150,
          child: Center(
            child: Text("Add new holidays",
              style: GoogleFonts.openSans(
                  color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        onTap: () async {

        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Date",
                                  style: GoogleFonts.openSans(
                                      fontSize: 15, color: Colors.black, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Holiday",
                                  style: GoogleFonts.openSans(
                                      fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 10.0),
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              side: BorderSide(width: 1, color: Colors.pink.shade900),
                            ),
                            onPressed: () {},
                            child: Text('Add',
                              style: GoogleFonts.openSans(
                                  fontSize: 12, color: Colors.black, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey.shade300,
                    ),
                  ],
                );
              },
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  side: BorderSide(width: 1, color: Colors.pink.shade900),
                ),
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text('Add all public holidays',
                    style: GoogleFonts.openSans(
                        fontSize: 13, color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
