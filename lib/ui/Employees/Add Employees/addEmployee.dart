import 'package:flutter/material.dart';
import '../../../common/widgets/addProfilePic.dart';
import '../../../common/widgets/appbarTXT.dart';
import '../../../common/widgets/submitContainer.dart';

class AddEmployeeScreen extends StatelessWidget {
  const AddEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        title: apBarText('Add Employee',Colors.white),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              firstRow(),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                thickness: 0.2,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                      hintText: 'Full Name',
                      isDense: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                  maxLines: 1,
                  minLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Mobile Number',
                      isDense: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                  maxLines: 1,
                  minLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                      hintText: 'Address',
                      isDense: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                  maxLines: 1,
                  minLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                      hintText: 'Designation',
                      isDense: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                  maxLines: 1,
                  minLines: 1,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            hintText: 'Salary',
                            isDense: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                        maxLines: 1,
                        minLines: 1,
                      ),
                    ),
                  ),
                  Expanded(
                      child: GestureDetector(
                          onTap: () {}, child: salaryContainer(txt: 'Yearly'))),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                      hintText: 'Gender',
                      isDense: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                  maxLines: 1,
                  minLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                      hintText: 'Reference',
                      isDense: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                  maxLines: 1,
                  minLines: 1,
                ),
              ),
              submitContainer(context, 'SUBMIT')
            ],
          ),
        ),
      ),
    );
  }
}

Widget firstRow() {
  return Row(
    children: [
      Expanded(child: addProfilePic(imageUrl: 'assets/icons/logo.png')),
      Expanded(
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                  hintText: 'Joining Date',
                  isDense: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
              maxLines: 1,
              minLines: 1,
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                  hintText: 'Employee ID',
                  isDense: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
              maxLines: 1,
              minLines: 1,
            ),
          ],
        ),
      )
    ],
  );
}

Widget salaryContainer({required String txt}) {
  return Padding(
    padding: const EdgeInsets.only(top: 20, left: 10),
    child: Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          color: Colors.pink.shade900,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Center(
        child: Text(
          txt,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
