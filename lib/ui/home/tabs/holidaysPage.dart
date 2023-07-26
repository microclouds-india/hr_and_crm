import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/repository/holidays/model/holidays.model.dart';
import 'package:hr_and_crm/ui/edit%20holiday/editHoliday.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../repository/holidayModel/holiday.dart';
import '../../Add new holiday/newHoliday.dart';
import '../../addPublicHolidays/addPublicHolidays.dart';

class HolidaysPage extends StatefulWidget {
  bool hr;
  HolidaysPage({required this.hr});

  @override
  State<HolidaysPage> createState() => _HolidaysPageState();
}

class _HolidaysPageState extends State<HolidaysPage> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate == null ? DateTime.now() : _selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  late HoliDayModel holiDayModel;


 Future <HoliDayModel> _getData()async{
    try {
      final prif = await SharedPreferences.getInstance();
      var endpint = 'https://cashbes.com/attendance/apis/holidays';
       var response = await http.post(Uri.parse(endpint),body: {
        'token':prif.getString('token')
       });
       if (response.statusCode==200) {
         var json = jsonDecode(response.body);
         holiDayModel = HoliDayModel.fromJson(json);
       }
    } catch (e) {
      Ui.getSnackBar(title: 'Data Not Available', context: context);
    }
    return holiDayModel;
  }

  Color getRandomColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    String viewDate = DateFormat('yyyy').format(_selectedDate);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        elevation: 0,
        title: Text(
          "Holidays List",
          style: GoogleFonts.openSans(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              _selectDate(context);
            },
            child: Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              child: Center(
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month, color: Colors.black),
                    const SizedBox(width: 5),
                    Text(
                      viewDate,
                      style: GoogleFonts.openSans(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Icon(Icons.arrow_drop_down, color: Colors.black),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GestureDetector(
        child: Visibility(
          visible: widget.hr,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) {
                return NewHolidayScreen();
              }),
            ),
            child: Container(
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.pink.shade900,
              ),
              height: kBottomNavigationBarHeight - 5,
              width: 150,
              child: Center(
                child: Text(
                  "Add new holidays",
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
        onTap: () async {},
      ),
      body: FutureBuilder(
        future: _getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
           
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: holiDayModel.data.length,
              itemBuilder: (context, index) {
                final color = getRandomColor();
                final DateFormat formatter = DateFormat('dd-MM-yyyy');
                final DateFormat monthFormatter = DateFormat('MMM');
                final String dateString = holiDayModel.data[index].holidayDate;
                DateTime date;
                try {
                  date = formatter.parse(dateString);
                } catch (e) {
                  date = DateTime.tryParse(dateString) ?? DateTime.now();
                }
                String formattedMonth = monthFormatter.format(date);
                String formattedDay = date.day.toString();
                String dateHoli = formatter.format(date);
                return Card(
                  elevation: 4,
                  shadowColor: Colors.black12,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 80,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              width: 120,
                              color: color,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      formattedDay,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      formattedMonth,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              child: ListTile(
                                trailing: Visibility(
                                  visible: widget.hr,
                                  child: PopupMenuButton(
                                    itemBuilder: (BuildContext context) {
                                      return [
                                        PopupMenuItem(
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Icon(Icons.edit),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('Edit'),
                                              ),
                                            ],
                                          ),
                                          value: 'edit',
                                        ),
                                        PopupMenuItem(
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Icon(Icons.delete,color: Colors.red,),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('Delete'),
                                              ),
                                            ],
                                          ),
                                          value: 'delete',
                                        ),
                                      ];
                                    },
                                    onSelected: (value) {
                                      // Handle menu item selection here
                                      if (value == 'edit') {
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                                        return EditHolidayScreen(
                                          date: holiDayModel.data[index].holidayDate,
                                          id: holiDayModel.data[index].id,
                                          tittle: holiDayModel.data[index].title,
                                        );
                                      }));
                                      } else if (value == 'delete') {
                                          Ui.showAlertDialog(
                                            context,
                                            'Confirmation',
                                            'Are you sure you want to remove this holiday?',
                                            () async {
                                              try {
                                                EasyLoading.show(status: 'Please Wait....');
                                                var response = await http.post(Uri.parse('https://cashbes.com/attendance/apis/holiday_remove'),body: {
                                                  'id':holiDayModel.data[index].id
                                                });
                                                var json = jsonDecode(response.body);
                                                 setState(() {
                                                    
                                                  });
                                                if (json['status']=='200') {
                                                  EasyLoading.dismiss();
                                                  Navigator.pop(context);
                                                  Ui.getSnackBar(title: 'Successful', context: context);
                                                 Navigator.of(context).pop();
                                                }else{
                                                  EasyLoading.dismiss();
                                                  Ui.getSnackBar(title: 'Faild', context: context);
                                                }
                                              } catch (e) {
                                                EasyLoading.dismiss();
                                                
                                              }
                                            },
                                            () {});
                                      }
                                    },
                                  ),
                                ),
                                title: Text(
                                  holiDayModel.data[index].title.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Text(dateHoli),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Holidays Not Availabe!')
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.pink.shade900,
              ),
            );
          }
        },
      ),
    );
  }
}
