import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/common/widgets/bookingFormTextFields.dart';
import 'package:hr_and_crm/common/widgets/submitContainer.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class EditHolidayScreen extends StatefulWidget {
  String id;
  String tittle;
  String date;
  EditHolidayScreen({required this.date,required this.id,required this.tittle});

  @override
  State<EditHolidayScreen> createState() => _EditHolidayScreenState();
}

class _EditHolidayScreenState extends State<EditHolidayScreen> {

TextEditingController _tittleController = TextEditingController();
 TextEditingController _dateController = TextEditingController();
 late DateTime _selectedDate;
 String _year ='';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd-MM-yyyy').format(_selectedDate);
        _year = DateFormat('yyyy').format(_selectedDate);
      });
    }
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tittleController.text= widget.tittle;
    _dateController.text= widget.date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
      title: apBarText('Edit Holiday', Colors.white),
      centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            BookingFormTextFields(
              iconData: Icons.calendar_month,
              hint: 'Holiday Text',controller: _tittleController,),
            BookingFormTextFields(
              iconData: Icons.calendar_month,
              hint: 'Date',controller: _dateController,
            suffixIcon: IconButton(onPressed: (){_selectDate(context);}, icon: Icon(Icons.calendar_month)),readOnly: true,),
            Spacer(),
            GestureDetector(
              onTap: ()async{
               if (_dateController.text.isEmpty&&_tittleController.text.isEmpty&&_year.isEmpty) {
                 Ui.getSnackBar(title: '', context: context);
               }else{
                 try {
                  EasyLoading.show(status: 'Please Wait...');
                  var response = await http.post(Uri.parse('https://cashbes.com/attendance/apis/edit_holiday'),body: {
                    'id':widget.id,
                    'year':_year,
                    'holiday_date': _dateController.text, 
                    'title':_tittleController.text
                  });
                  if (response.statusCode==200) {
                    var json = jsonDecode(response.body);
                    if (json['status']=='200') {
                      EasyLoading.dismiss();
                      Ui.getSnackBar(title: 'Holiday Changed', context: context);
                      Navigator.of(context).pop();
                    }else{
                      EasyLoading.dismiss();
                    }
                  }
                } catch (e) {
                  Ui.getSnackBar(title: 'Server Error', context: context);
                  EasyLoading.dismiss();
                }
               }
              },
              child: submitContainer(context, 'Save'))
          ],
        ),
      ),
    );
  }
}