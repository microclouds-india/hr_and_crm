import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/ui/Employees/Documents/view_document.dart';

class EmployeeDocuments extends StatelessWidget {
  EmployeeDocuments({super.key});
  List<String> docuname = [
    'Adhar',
    'Address Proof',
    'Background Verification',
    'Bank Account Details',
    'Degree',
    'Driving Licece',
    'Employment Contract',
    'PAN Card',
    'Police Verification',
    'Salary Slip',
    'Previous Empolyment Documents',
    'Professional Documents',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.pink.shade900,
        //   onPressed: () {
        //     _showMyDialog(context);
        //   },
        //   child: const Center(
        //     child: Icon(
        //       Icons.add,
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
        appBar: AppBar(
          backgroundColor: Colors.pink.shade900,
          centerTitle: true,
          title: apBarText('''Mirshad's Documents''', Colors.white),
        ),
        body: ListView.builder(
          itemCount: docuname.length,
          itemBuilder: (context, index) {
            return folders(docuname[index], context);
          },
        ));
  }

  GestureDetector folders(String txt, BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return ViewDocuments(
          documentName: txt,
        );
      })),
      child: ListTile(
        leading: Image(
            height: 20,
            width: 20,
            fit: BoxFit.cover,
            image: AssetImage('assets/icons/folders.png')),
        title: Text(txt),
      ),
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Upload Documents')),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your folder name'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                    child: Container(
                  decoration: BoxDecoration(
                      color: Colors.pink.shade900,
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.upload,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Upload Documents',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                )),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.pink.shade900),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Save',
                style: TextStyle(color: Colors.pink.shade900),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                const snackBar = SnackBar(
                  content: Text('Document Upload Successfully!'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ],
        );
      },
    );
  }
}
