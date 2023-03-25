import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TemplatePage extends StatelessWidget {
  const TemplatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        elevation: 0,
        title: Text(
          "Create Template",
          style: GoogleFonts.openSans(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
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
            child: Text(
              "Create Template",
              style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        onTap: () async {},
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: double.infinity,
                child: Row(
                  children: [
                    const Expanded(
                        child: Text(
                      "Basic",
                      style: TextStyle(fontSize: 18),
                    )),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            side: BorderSide(
                                width: 1, color: Colors.pink.shade900),
                          ),
                          onPressed: () {},
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 15.0, bottom: 15.0),
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
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0),
                      color: Colors.pink.shade200,
                    ),
                    margin: const EdgeInsets.all(10.0),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        side: BorderSide(width: 1, color: Colors.pink.shade200),
                      ),
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Text(
                          'Add Allowances',
                          style: GoogleFonts.openSans(
                              fontSize: 13,
                              color: Colors.pink.shade900,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Text(
                "Employer Contribution",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10,),
              EmployerChild("Employer PF"),
            ],
          ),
        ),
      ),
    );
  }
}

Widget EmployerChild(String text) {
  return Container(
    child: Row(
      children: [
        Expanded(
          child: Text(text),
        ),
        SizedBox(),
      ],
    ),
  );
}
