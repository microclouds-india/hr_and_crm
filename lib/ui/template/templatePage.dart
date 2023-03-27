import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_and_crm/common/widgets/bookingFormTextFields.dart';

class TemplatePage extends StatefulWidget {
  const TemplatePage({Key? key}) : super(key: key);

  @override
  State<TemplatePage> createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
  bool? check1 = false;

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
                  children: const [
                    Expanded(
                        child: Text(
                      "Basic",
                      style: TextStyle(fontSize: 18),
                    )),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: BookingFormTextFields(
                          hint: "0",
                          maxLines: 1,
                          suffixIcon: Icon(Icons.percent_outlined),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Padding(
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
                          side:
                              BorderSide(width: 1, color: Colors.pink.shade200),
                        ),
                        onPressed: () {},
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 15.0, bottom: 15.0),
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
              ),
              Text(
                "Employer Contribution",
                style: GoogleFonts.openSans(
                    fontSize: 19,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              EmployerChild("Employer PF"),
              EmployerChild("Employer ESI"),
              Row(
                children: [
                  Text(
                    "PF EDLI & Admin Charges",
                    style: GoogleFonts.openSans(
                        fontSize: 15,
                        color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  //true for checked checkbox, false for unchecked one
                  Row(
                    children: [
                      Checkbox(
                          //only check box
                          value: check1, //unchecked
                          onChanged: (bool? value) {
                            //value returned when checkbox is clicked
                            setState(() {
                              check1 = value;
                            });
                          }),
                      Text(
                        "Not Applied",
                        style: GoogleFonts.openSans(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  )
                ],
              ),
              EmployerChild("Labour Welfare Fund"),
              Text(
                "Deductions",
                style: GoogleFonts.openSans(
                    fontSize: 19,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              EmployerChild("Employer PF"),
              EmployerChild("Employer ESI"),
              EmployerChild("PT"),
            ],
          ),
        ),
      ),
    );
  }
}

Widget EmployerChild(String text) {
  return Row(
    children: [
      Expanded(
        child: Text(
          text,
          style: GoogleFonts.openSans(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
      OutlinedButton(
        onPressed: () {},
        child: Center(
          child: Text(
            "Not Selected",
            style: GoogleFonts.openSans(
                fontSize: 12, color: Colors.blue, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    ],
  );
}
