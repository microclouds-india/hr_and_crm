import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/common/widgets/bookingFormTextFields.dart';
import 'package:hr_and_crm/common/widgets/submitContainer.dart';
import 'package:hr_and_crm/ui/work%20shift/work_shift_all.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditWorkShiftes extends StatefulWidget {
  String name;
  String id;
  bool hr;
  EditWorkShiftes({required this.name,required this.id,required this.hr});

  @override
  State<EditWorkShiftes> createState() => _EditWorkShiftesState();
}

class _EditWorkShiftesState extends State<EditWorkShiftes> {
  TextEditingController _shiftController = TextEditingController();

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _shiftController.text = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
          return WorkShiftAll(
            hr: widget.hr,
          );
        }));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.pink.shade900,
        centerTitle: true,
        leading: IconButton(onPressed: (){
           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
          return WorkShiftAll(
            hr: widget.hr,
          );
        }));
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        title: apBarText('Edit Workshift', Colors.white)),
        body: Padding(
          padding: const EdgeInsets.only(top: 10,bottom: 10),
          child: Column(
            children: [
              BookingFormTextFields(
                iconData: Icons.date_range,
                hint: 'shift',controller: _shiftController,),
              BookingFormTextFields(hint: 'date',iconData: Icons.date_range),
              Spacer(),
              GestureDetector(
                onTap: ()async{
                  try {
                    final prif = await SharedPreferences.getInstance();
                    var response = await http.post(Uri.parse('https://cashbes.com/attendance/apis/edit_workshift'),body: {
                      'id':widget.id,
                      'branch_name':prif.getString('branch_name').toString(),
                      'address':_shiftController.text
                    });
                    if (response.statusCode==200) {
                      Ui.getSnackBar(title: 'Workshift Changed!', context: context);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                        return WorkShiftAll(
                          hr: widget.hr,
                        );
                      }));
                    }
                  } catch (e) {
                    
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