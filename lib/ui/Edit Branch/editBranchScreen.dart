import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/common/widgets/bookingFormTextFields.dart';
import 'package:hr_and_crm/common/widgets/submitContainer.dart';
import 'package:hr_and_crm/ui/branches/branches.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditBranchScreen extends StatefulWidget {
  String id;
  String branchName;
  String address;
  EditBranchScreen(
      {required this.address, required this.branchName, required this.id});

  @override
  State<EditBranchScreen> createState() => _EditBranchScreenState();
}

class _EditBranchScreenState extends State<EditBranchScreen> {
  TextEditingController _nameController = TextEditingController();

  TextEditingController _addressController = TextEditingController();

  ediData() async {
    try {
      EasyLoading.show(status: 'Please Wait...');
      var endPoint = 'https://cashbes.com/attendance/apis/edit_branch';
      var response = await http.post(Uri.parse(endPoint), body: {
        'id': widget.id,
        'branch_name': _nameController.text,
        'address': _addressController.text
      });
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        Ui.getSnackBar(title: 'Branch name changed', context: context);
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return Branches();
        }));
      } else {
        EasyLoading.dismiss();
        Ui.getSnackBar(title: 'Faild!', context: context);
      }
    } catch (e) {
      EasyLoading.dismiss();
      Ui.getSnackBar(title: 'Server Error!', context: context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text = widget.branchName;
    _addressController.text = widget.address;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return Branches();
        }));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink.shade900,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return Branches();
                }));
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: apBarText('Edit Branch', Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              BookingFormTextFields(
                iconData: Icons.person,
                hint: 'Branch Name',
                controller: _nameController,
              ),
              BookingFormTextFields(
                iconData: Icons.location_on,
                hint: 'Address',
                controller: _addressController,
              ),
              Spacer(),
              GestureDetector(
                  onTap: () {
                    if (_nameController.text.isEmpty &&
                        _addressController.text.isEmpty 
                        ) {
                          Ui.getSnackBar(title: 'Please Enter a ', context: context);
                        }else{
                          ediData();
                        }
                  },
                  child: submitContainer(context, 'Save'))
            ],
          ),
        ),
      ),
    );
  }
}
