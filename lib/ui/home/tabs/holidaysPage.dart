import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

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

  HoliDayModel holiDayModel = HoliDayModel();
  bool loading = false;

  getHoliday() async {
    var url = Uri.parse('https://cashbes.com/attendance/apis/holidays');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      holiDayModel = HoliDayModel.fromJson(json);
      setState(() {
        loading = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getHoliday();
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
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
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
                  color: Colors.white),
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
                          fontWeight: FontWeight.w600),
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
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) {
              return NewHolidayScreen();
            })),
            child: Container(
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.pink.shade900),
              height: kBottomNavigationBarHeight - 5,
              width: 150,
              child: Center(
                child: Text(
                  "Add new holidays",
                  style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
        onTap: () async {},
      ),
      body: loading
          ? SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: holiDayModel.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        holiDayModel.data![index].holidayDate ??
                                            'Tittile',
                                        style: GoogleFonts.openSans(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "Holiday",
                                        style: GoogleFonts.openSans(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: widget.hr,
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10.0),
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                      ),
                                      side: BorderSide(
                                          width: 1,
                                          color: Colors.pink.shade900),
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      'Add',
                                      style: GoogleFonts.openSans(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.grey.shade300,
                          ),
                        ],
                      );
                    },
                  ),
                  Visibility(
                    visible: widget.hr,
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 10.0),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          side:
                              BorderSide(width: 1, color: Colors.pink.shade900),
                        ),
                        onPressed: () => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return PublicHolidayScreen();
                        })),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Add all public holidays',
                            style: GoogleFonts.openSans(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                color: Colors.pink.shade900,
              ),
            ),
    );
  }
}
