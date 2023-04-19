import 'package:flutter/material.dart';
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
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Add Branches",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border.all(
                    color: Colors.grey.shade200,
                    //color of border
                    width: 2, //width of border
                  ),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    BookingFormTextFields(
                      keyboardType: TextInputType.phone,
                      controller: branchNameController,
                      hint: 'Branch Name',
                      maxLines: 1,
                    ),
                    BookingFormTextFields(
                      keyboardType: TextInputType.phone,
                      controller: addressController,
                      hint: 'Address',
                      maxLines: 1,
                    ),
                    BookingFormTextFields(
                      keyboardType: TextInputType.phone,
                      controller: dateController,
                      hint: 'Date',
                      maxLines: 1,
                    ),
                    BookingFormTextFields(
                      keyboardType: TextInputType.phone,
                      controller: timeController,
                      hint: 'Time',
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
