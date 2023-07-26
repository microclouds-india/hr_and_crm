import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/common/widgets/bookingFormTextFields.dart';
import 'package:hr_and_crm/common/widgets/submitContainer.dart';
import 'package:hr_and_crm/repository/edit%20and%20delete%20leavetypes/add/notifier.dart';
import 'package:hr_and_crm/ui/Leave%20typs/leaveTypes.dart';
import 'package:provider/provider.dart';

class AddLeaveTypeScreen extends StatefulWidget {
  const AddLeaveTypeScreen({super.key});

  @override
  State<AddLeaveTypeScreen> createState() => _AddLeaveTypeScreenState();
}

class _AddLeaveTypeScreenState extends State<AddLeaveTypeScreen> {
  @override
  Widget build(BuildContext context) {
    final data =Provider.of<AddLeaveTypeNotifier>(context,listen: false);
     TextEditingController _controller = TextEditingController();
    return WillPopScope(
      onWillPop: ()async{
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
        return LeaveTypesScreen();
      }));
      return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink.shade900,
          centerTitle: true,
          title: apBarText('Add Leavetype', Colors.white),
          leading: IconButton(onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
              return LeaveTypesScreen();
            }));
          }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              BookingFormTextFields(
                controller: _controller,
                iconData: Icons.add, hint: 'Enter Leave Type Name'),
              Spacer(),
              GestureDetector(
                onTap: (){
                  if (_controller.text.isEmpty) {
                    Ui.getSnackBar(title: 'Please enter LeaveType name!', context: context);
                  }else{
                    data.fetchData(_controller.text, context);
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