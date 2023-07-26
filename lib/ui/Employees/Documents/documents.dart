import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/common/widgets/bookingFormTextFields.dart';
import 'package:hr_and_crm/repository/documets%20view/model/model.dart';
import 'package:hr_and_crm/ui/Employees/Documents/view_document.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeDocuments extends StatefulWidget {
  EmployeeDocuments({super.key});

  @override
  State<EmployeeDocuments> createState() => _EmployeeDocumentsState();
}

class _EmployeeDocumentsState extends State<EmployeeDocuments> {
  // List<String> docuname = [
  late File _file;
  late DocumetViewModel model;
  bool _load = false;

  Future<http.Response> getdata() async {
    final prif = await SharedPreferences.getInstance();
    var response = await http.post(
        Uri.parse('https://cashbes.com/attendance/apis/document_view'),
        body: {'token': prif.getString('token')});
    // body: {'token': '19168353658646464646464'});
    return response;
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      allowMultiple: false,
    );

    if (result != null) {
      String? path = result.files.single.path;
      _file = File(path!);

      // Handle the picked file (e.g., display it, upload it, etc.)
      print(_file.path);
    } else {
      // User canceled the file picking.
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _fileNameController = TextEditingController();
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pink.shade900,
          onPressed: () {
            _showMyDialog(context, _fileNameController);
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
        body: FutureBuilder(
          future: getdata(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var json = jsonDecode(snapshot.data!.body);
              if (json['status'] == '400') {
                return Center(
                  child: Text('No Documents'),
                );
              } else {
                model = DocumetViewModel.fromJson(json);
                return ListView.builder(
                  itemCount: model.data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return DocumentViewScreen(
                                file: model.data[index].filename);
                          }));
                        },
                        child: folders(model.data[index].title, context,model.data[index].id));
                  },
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.pink.shade900,
                ),
              );
            }
          },
        ));
  }

  ListTile folders(String txt, BuildContext context,String id) {
    return ListTile(
      trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () async {
            Ui.showAlertDialog(context, 'Confirmation', 'Are you sure you want to remove this document?', ()async{
              try {
              EasyLoading.show(status: 'Please Wait...');
              var response = await http.post(Uri.parse('https://cashbes.com/attendance/apis/documents_remove'),
              body: {
                'id':id
              });
              if (response.statusCode==200) {
                EasyLoading.dismiss();
                                Ui.getSnackBar(title: 'Document Deleted!', context: context);
                setState(() {
                });
                Navigator.of(context).pop();

              }
            } catch (e) {
              EasyLoading.dismiss();
            }
             }, () { 
              Navigator.of(context).pop();
             });
          }),
      leading: const Image(
          height: 20,
          width: 20,
          fit: BoxFit.cover,
          image: AssetImage('assets/icons/folders.png')),
      title: Text(txt),
    );
  }

  Future<void> _showMyDialog(
      BuildContext context, TextEditingController fileNameCntrl) async {
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
                  iconData: Icons.file_copy,
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
                    pickFile();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.pink.shade900,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
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
              onPressed: () async {
                if (_file.path == null ||
                    _file.path.isEmpty && fileNameCntrl.text == null ||
                    fileNameCntrl.text.isEmpty) {
                  Navigator.of(context).pop();
                  Ui.getSnackBar(
                      title: 'Please Upload Your Document!', context: context);
                } else {
                  await EasyLoading.show(status: 'Please Wait...');
                  final prif = await SharedPreferences.getInstance();
                  var headers = {
                    'Cookie':
                        'ci_session=481780ab437dbe41cce61fab1091bf4fc0436c8c'
                  };
                  var request = http.MultipartRequest(
                      'POST',
                      Uri.parse(
                          'https://cashbes.com/attendance/apis/document_upload'));
                  request.fields.addAll({
                    'token': prif.getString('token')!,
                    'title': fileNameCntrl.text
                  });
                  request.files.add(
                      await http.MultipartFile.fromPath('file[]', _file.path));
                  request.headers.addAll(headers);

                  http.StreamedResponse response = await request.send();

                  if (response.statusCode == 200) {
                    getdata();
                    await EasyLoading.dismiss();
                    Ui.getSnackBar(
                        title: 'Flie Upload Completed', context: context);
                    print(await response.stream.bytesToString());
                  } else {
                    print(response.reasonPhrase);
                  }

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
