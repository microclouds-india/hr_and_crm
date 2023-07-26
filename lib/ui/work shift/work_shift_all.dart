import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/repository/branches/model/branches.model.dart';
import 'package:hr_and_crm/ui/work%20shift/addWorkShift.dart';
import 'package:hr_and_crm/ui/work%20shift/editWorlShift.dart';
import 'package:http/http.dart' as http;
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../repository/work shifts/work_shifts_model.dart';

enum SampleItem { delete, edit }

class WorkShiftAll extends StatefulWidget {
  bool hr;
  WorkShiftAll({required this.hr});
  @override
  State<WorkShiftAll> createState() => _WorkShiftAllState();
}

class _WorkShiftAllState extends State<WorkShiftAll> {
  // late BranchesModel branchesModel;
  late WorkShiftsModel model;
  // bool? _user;

  Future<WorkShiftsModel> _getData() async {
   try {
     final prif = await SharedPreferences.getInstance();
    var response = await http
        .post(Uri.parse('https://cashbes.com/attendance/apis/working_shifts'),body: {
          'token': prif.getString('token').toString(),
        });
    final json = jsonDecode(response.body);
    model = WorkShiftsModel.fromJson(json);
   } catch (e) {
     print(e);
   } 
   return model;
  }


  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Visibility(
          visible: widget.hr,
          child: FloatingActionButton(
            backgroundColor: Colors.pink.shade900,
            onPressed: () {
              // _modalBottomSheetMenu();
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return AddWorkShift(
                  hr: widget.hr,
                );
              }));
            },
            child: Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          backgroundColor: Colors.pink.shade900,
          centerTitle: true,
          title: apBarText('Working Shifts', Colors.white),
        ),
        body: FutureBuilder(
          future: _getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3.0,
                    child: ListTile(
                      leading: Icon(Icons.access_time,color: Colors.pink.shade900,),
                      title: Text(snapshot.data!.data[index].shift),
                      subtitle: Text(snapshot.data!.data[index].shiftTime),
                    ),
                  );
                },
              );
            } else if(snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.pink.shade900,
                ),
              );
            }else if (!snapshot.hasData){
              return Center(child: Text('Datas Not Availabe'),);
            }else{
              return Center(child: SizedBox(),);
            }
          },
        ));
  }

  // void _modalBottomSheetMenu() {
  //   showModalBottomSheet(
  //       context: context,
  //       backgroundColor: Colors.white,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
  //       ),
  //       builder: (context) {
  //         return Padding(
  //           padding: const EdgeInsets.only(left: 20, right: 20),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: <Widget>[
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Container(
  //                       height: 5,
  //                       width: 40,
  //                       decoration: BoxDecoration(
  //                           color: Colors.grey,
  //                           borderRadius:
  //                               BorderRadius.all(Radius.circular(10))),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //               SizedBox(height: 5,),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Text('Add Work Shift',style: TextStyle(
  //                       fontWeight: FontWeight.bold
  //                     ),)
  //                   )
  //                 ],
  //               ),
  //               SizedBox(height: 5,),
  //               // Padding(
  //               //   padding: const EdgeInsets.only(
  //               //     left: 8.0,
  //               //     right: 8.0,
  //               //   ),
  //               //   child: DropdownButton<String>(
  //               //     borderRadius: const BorderRadius.all(Radius.circular(20)),
  //               //     isExpanded: true,
  //               //     value: _dropdownValue,
  //               //     icon: const Icon(Icons.arrow_downward),
  //               //     onChanged: (String? newValue) {
  //               //       setState(() {
  //               //         _dropdownValue = newValue!;
  //               //       });
  //               //     },
  //               //     items:
  //               //         _options.map<DropdownMenuItem<String>>((String value) {
  //               //       return DropdownMenuItem<String>(
  //               //         value: value,
  //               //         child: Text(value),
  //               //       );
  //               //     }).toList(),
  //               //   ),
  //               // ),
  //               BookingFormTextFields(
  //                 hint: 'Shift name',
  //                 controller: _shiftController,
  //               ),
  //               GestureDetector(
  //                 onTap: () async {
  //                   final TimeOfDay? pickedTime = await showTimePicker(
  //                     context: context,
  //                     initialTime: TimeOfDay.now(),
  //                   );

  //                   if (pickedTime != null && pickedTime != _selectedFromTime) {
  //                     setState(() {
  //                       _selectedFromTime = pickedTime;
  //                     });
  //                   }
  //                 },
  //                 child: AbsorbPointer(
  //                   child: BookingFormTextFields(
  //                       hint: _selectedFromTime == null
  //                           ? 'Select From Time'
  //                           : _selectedFromTime.toString()),
  //                 ),
  //               ),
  //               GestureDetector(
  //                 onTap: () async {
  //                   final TimeOfDay? pickedTime = await showTimePicker(
  //                     context: context,
  //                     initialTime: TimeOfDay.now(),
  //                   );

  //                   if (pickedTime != null && pickedTime != _selectedToTime) {
  //                     setState(() {
  //                       _selectedToTime = pickedTime;
  //                     });
  //                   }
  //                 },
  //                 child: AbsorbPointer(
  //                   child: BookingFormTextFields(
  //                     hint: _selectedToTime == null
  //                         ? 'Select To Time'
  //                         : _selectedToTime.toString(),
  //                   ),
  //                 ),
  //               ),
  //               GestureDetector(
  //                   onTap: () {
  //                     print(_selectedToTime);
  //                     if (_shiftController.text.isEmpty &&
  //                         _selectedFromTime == null &&
  //                         _selectedToTime == null) {
  //                       Navigator.of(context).pop();
  //                       Ui.getSnackBar(
  //                           title: "Please Enter Values!", context: context);
  //                     } else {
  //                       _addWorkShift(_shiftController.text,
  //                           '${_selectedFromTime!.hour}:${_selectedFromTime!.minute} to ${_selectedToTime!.hour}:${_selectedToTime!.minute}');
  //                       _shiftController.clear();
  //                       _selectedFromTime = null;
  //                       _selectedToTime = null;
  //                     }
  //                   },
  //                   child: submitContainer(context, 'Submit'))
  //             ],
  //           ),
  //         );
  //       });
  // }
  Widget _buildShiftItem(String shiftName, String time, String id) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shiftName,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Time: $time',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            Visibility(
              visible: widget.hr,
              child: PopupMenuButton<SampleItem>(
                initialValue: selectedMenu,
                // Callback that sets the selected popup menu item.
                onSelected: (SampleItem item) {
                  selectedMenu = item;
                  if (selectedMenu == SampleItem.edit) {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      return EditWorkShiftes(
                        hr: widget.hr,
                        name: shiftName,
                        id: id,
                      );
                    }));
                  } else {
                    Ui.showAlertDialog(context, 'Delete Work Shift',
                        'Are you sure you want to delete this work shift?',
                        () async {
                      try {
                        EasyLoading.show(status: 'Please Wait...');
                        Navigator.of(context).pop();
                        var response = await http.post(
                            Uri.parse(
                                'https://cashbes.com/attendance/apis/workshifts_remove'),
                            body: {'id': id});
                        if (response.statusCode == 200) {
                          EasyLoading.dismiss();
                          Navigator.of(context).pop();
                          Ui.getSnackBar(
                              title: 'Workshift Removed', context: context);
                        } else {
                          EasyLoading.dismiss();
                          Navigator.of(context).pop();
            
                          Ui.getSnackBar(
                              title: 'Workshift not removerd!', context: context);
                        }
                      } catch (e) {
                        EasyLoading.dismiss();
                        Navigator.of(context).pop();
            
                        Ui.getSnackBar(title: 'Error', context: context);
                      }
                    }, () {
                      Navigator.of(context).pop();
                    });
                  }
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<SampleItem>>[
                  const PopupMenuItem<SampleItem>(
                    value: SampleItem.edit,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.edit),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Edit'),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuItem<SampleItem>(
                    value: SampleItem.delete,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.delete,color: Colors.pink,),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Delete'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
