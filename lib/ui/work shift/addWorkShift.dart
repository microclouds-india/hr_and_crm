import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/ui/work%20shift/work_shift_all.dart';
import 'package:http/http.dart' as http;

import '../../common/ui.dart';
import '../../common/widgets/bookingFormTextFields.dart';
import '../../common/widgets/submitContainer.dart';
import '../../repository/branches/model/branches.model.dart';

class AddWorkShift extends StatefulWidget {
  bool hr;
   AddWorkShift({required this.hr});

  @override
  State<AddWorkShift> createState() => _AddWorkShiftState();
}

class _AddWorkShiftState extends State<AddWorkShift> {

    TimeOfDay? _selectedFromTime;
  TimeOfDay? _selectedToTime;
  TextEditingController _shiftController = TextEditingController();
  


  _addWorkShift(String shift, String time) async {
    EasyLoading.show(status: 'Please Wait...');
    var response = await http.post(
        Uri.parse('https://cashbes.com/attendance/apis/add_workshift'),
        body: {'branch_id': '1', 'shift': shift, 'shift_time': time});
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      Ui.getSnackBar(title: 'Work Repost Shift Added', context: context);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
              return WorkShiftAll(
                hr: widget.hr,
              );
            }));
    } else {
      EasyLoading.dismiss();
      Ui.getSnackBar(title: 'Work Repot Shift Not Added!', context: context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
              return WorkShiftAll(
                hr: widget.hr,
              );
            }));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: apBarText('Add Work Shift', Colors.white),
          centerTitle: true,
          backgroundColor: Colors.pink.shade900,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                return WorkShiftAll(
                  hr: widget.hr,
                );
              }));
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),),
        body: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20,top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Container(
                  //         height: 5,
                  //         width: 40,
                  //         decoration: BoxDecoration(
                  //             color: Colors.grey,
                  //             borderRadius:
                  //                 BorderRadius.all(Radius.circular(10))),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  // SizedBox(height: 5,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Text('Add Work Shift',style: TextStyle(
                  //         fontWeight: FontWeight.bold
                  //       ),)
                  //     )
                  //   ],
                  // ),
                  SizedBox(height: 5,),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //     left: 8.0,
                  //     right: 8.0,
                  //   ),
                  //   child: DropdownButton<String>(
                  //     borderRadius: const BorderRadius.all(Radius.circular(20)),
                  //     isExpanded: true,
                  //     value: _dropdownValue,
                  //     icon: const Icon(Icons.arrow_downward),
                  //     onChanged: (String? newValue) {
                  //       setState(() {
                  //         _dropdownValue = newValue!;
                  //       });
                  //     },
                  //     items:
                  //         _options.map<DropdownMenuItem<String>>((String value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value,
                  //         child: Text(value),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: BookingFormTextFields(
                      iconData: Icons.person,
                      hint: 'Shift name',
                      controller: _shiftController,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
    
                      if (pickedTime != null && pickedTime != _selectedFromTime) {
                        setState(() {
                          _selectedFromTime = pickedTime;
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: BookingFormTextFields(
                        iconData: Icons.calendar_month,
                          hint: _selectedFromTime == null
                              ? 'Select From Time'
                              : _selectedFromTime.toString()),
                    ),
                  ),
                  SizedBox(height: 8,),
                  GestureDetector(
                    onTap: () async {
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                    
                      if (pickedTime != null && pickedTime != _selectedToTime) {
                        setState(() {
                          _selectedToTime = pickedTime;
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: BookingFormTextFields(
                        iconData: Icons.calendar_month,
                        hint: _selectedToTime == null
                            ? 'Select To Time'
                            : _selectedToTime.toString(),
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        print(_selectedToTime);
                        if (_shiftController.text.isEmpty &&
                            _selectedFromTime == null &&
                            _selectedToTime == null) {
                          Navigator.of(context).pop();
                          Ui.getSnackBar(
                              title: "Please Enter Values!", context: context);
                        } else {
                          _addWorkShift(_shiftController.text,
                              '${_selectedFromTime!.hour}:${_selectedFromTime!.minute} to ${_selectedToTime!.hour}:${_selectedToTime!.minute}');
                          _shiftController.clear();
                          _selectedFromTime = null;
                          _selectedToTime = null;
                        }
                      },
                      child: submitContainer(context, 'Submit'))
                ],
              ),
        ),
      ),
    );
  }
}