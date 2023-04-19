import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_and_crm/common/widgets/bookingFormTextFields.dart';

class AddBranches extends StatefulWidget {
  const AddBranches({Key? key}) : super(key: key);

  @override
  State<AddBranches> createState() => _AddBranchesState();
}

class _AddBranchesState extends State<AddBranches> {

  TextEditingController branchNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Add Branches",
          style: TextStyle(color: Colors.white),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.pink.shade900),
          height: kBottomNavigationBarHeight - 5,
          width: double.infinity,
          child: Center(
            child: Text(
              "Submit",
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                BookingFormTextFields(
                  keyboardType: TextInputType.phone,
                  controller: branchNameController,
                  hint: 'Branch Name',
                  maxLines: 1,
                ),
                const SizedBox(height: 20.0),
                BookingFormTextFields(
                  keyboardType: TextInputType.phone,
                  controller: addressController,
                  hint: 'Address',
                  maxLines: 1,
                ),
                const SizedBox(height: 20.0),
                BookingFormTextFields(
                  keyboardType: TextInputType.phone,
                  controller: dateController,
                  hint: 'Date',
                  maxLines: 1,
                ),
                const SizedBox(height: 20.0),
                BookingFormTextFields(
                  keyboardType: TextInputType.phone,
                  controller: timeController,
                  hint: 'Time',
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
