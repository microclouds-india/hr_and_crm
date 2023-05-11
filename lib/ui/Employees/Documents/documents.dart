import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/common/widgets/bookingFormTextFields.dart';
import 'package:hr_and_crm/repository/documents/notifier/upload_document_notifier.dart';
import 'package:hr_and_crm/ui/Employees/Documents/view_document.dart';
import 'package:provider/provider.dart';

class EmployeeDocuments extends StatelessWidget {
  EmployeeDocuments({super.key});
  // List<String> docuname = [
  //   'Adhar',
  //   'Address Proof',
  //   'Background Verification',
  //   'Bank Account Details',
  //   'Degree',
  //   'Driving Licece',
  //   'Employment Contract',
  //   'PAN Card',
  //   'Police Verification',
  //   'Salary Slip',
  //   'Previous Empolyment Documents',
  //   'Professional Documents',
  //   'Other'
  // ];
  File? _file;

  getFiles(
    BuildContext context,
  ) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      _file = File(result.files.single.path.toString());
      print(_file!.path);
    } else {
      Navigator.of(context).pop();
      Ui.getSnackBar(title: 'No File Selected', context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _fileNameController = TextEditingController();
    final data = Provider.of<UploadDocumentsNotier>(context, listen: false);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pink.shade900,
          onPressed: () {
            _showMyDialog(context, data, _fileNameController);
          },
          child: const Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.pink.shade900,
          centerTitle: true,
          title: apBarText(''' Documents''', Colors.white),
        ),
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return folders('dd', context);
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

  Future<void> _showMyDialog(
      BuildContext context,
      UploadDocumentsNotier uploadDocumentsNotier,
      TextEditingController fileNameCntrl) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Upload Documents')),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                BookingFormTextFields(
                  controller: fileNameCntrl,
                  hint: 'Enter your file name',
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                    child: GestureDetector(
                  onTap: () {
                    // uploadDocumentsNotier.UploadDatas(
                    //     fileNameCntrl.text, uploadDocumentsNotier.file.path);
                    getFiles(
                      context,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.pink.shade900,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
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
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
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
                if (_file!.path == null ||
                    _file!.path.isEmpty && fileNameCntrl.text == null ||
                    fileNameCntrl.text.isEmpty) {
                  Navigator.of(context).pop();
                  Ui.getSnackBar(
                      title: 'Please Upload Your Document!', context: context);
                } else {
                  uploadDocumentsNotier.UploadDatas(
                      fileNameCntrl.text, _file!.path, context);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
