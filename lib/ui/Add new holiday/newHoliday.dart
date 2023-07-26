import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/common/widgets/bookingFormTextFields.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../repository/addHoliday/notifier/add_holiday_notifier.dart';

class NewHolidayScreen extends StatefulWidget {
  @override
  _NewHolidayScreenState createState() => _NewHolidayScreenState();
}

class _NewHolidayScreenState extends State<NewHolidayScreen> {
  final TextEditingController _nameController = TextEditingController();
  TextEditingController _textEditingController = TextEditingController();
  String? year;
  DateTime? _selectedDate;
   Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _textEditingController.text = DateFormat('dd-MM-yyyy').format(picked);
        year = DateFormat('yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<AddHolidayNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pink.shade900,
        title: apBarText('New Holiday', Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BookingFormTextFields(
              iconData: Icons.title,
              controller: _nameController,
              hint: 'Holiday Tittle',
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: (){
                _selectDate();
              },
              child: AbsorbPointer(
                child: BookingFormTextFields(
                  iconData: Icons.calendar_month,
                  controller: _textEditingController,
                  hint: 'Date',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () {
                    _selectDate();
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
              
                if (_textEditingController.text.isEmpty ||
                    _nameController.text.isEmpty 
                  ) {
                  Ui.getSnackBar(
                      title: 'Please Enter a Value', context: context);
                } else {
                  data.addHolidays(
                      context: context,
                      year: year!,
                      holidayDate: _textEditingController.text == ''
                          ? data.date
                          : _textEditingController.text,
                      tittle: _nameController.text);
                }
                Navigator.of(context).pop();
              },
              child: Text('Save'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink.shade900),
            )
          ],
        ),
      ),
    );
  }



  @override
  void dispose() {
    _nameController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }
}
