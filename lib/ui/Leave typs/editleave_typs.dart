import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/common/widgets/bookingFormTextFields.dart';
import 'package:hr_and_crm/common/widgets/submitContainer.dart';
import 'package:hr_and_crm/repository/edit%20and%20delete%20leavetypes/edit%20leave%20types/notifier/notifier.dart';
import 'package:hr_and_crm/ui/Leave%20typs/leaveTypes.dart';
import 'package:provider/provider.dart';

class EditLeaveTypesScreen extends StatefulWidget {
  String text;
  String id;
  EditLeaveTypesScreen({required this.text,required this.id});

  @override
  State<EditLeaveTypesScreen> createState() => _EditLeaveTypesScreenState();
}

class _EditLeaveTypesScreenState extends State<EditLeaveTypesScreen> {
  TextEditingController _controller = TextEditingController();

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text = widget.text;
  }


  @override
  Widget build(BuildContext context) {
    final edit = Provider.of<EditLeaveTyesNotifier>(context,listen: false);
    return WillPopScope(onWillPop: ()async{
      
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
        return LeaveTypesScreen();
      }));
      return true;
    },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
            return LeaveTypesScreen();
          }));}, icon: Icon(Icons.arrow_back_ios)),
          backgroundColor: Colors.pink.shade900,
          title: apBarText('Edit Leave Types', Colors.white),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              BookingFormTextFields(
                controller: _controller,
                iconData: Icons.edit, hint: 'Enter leave type name'),
              Spacer(),
              GestureDetector(
                onTap: ()async{
                  if (_controller.text.isEmpty) {
                    Ui.getSnackBar(title: 'Please enter leavetype name', context: context);
                  }else{
                    edit.fetchData(widget.id, _controller.text,context);
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