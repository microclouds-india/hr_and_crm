import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../repository/addHoliday/notifier/add_holiday_notifier.dart';

class NewHolidayScreen extends StatefulWidget {
  @override
  _NewHolidayScreenState createState() => _NewHolidayScreenState();
}

class _NewHolidayScreenState extends State<NewHolidayScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

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
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Holiday Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Date',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () {
                    _selectDate(context, data);
                  },
                ),
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                if (data.year.isEmpty ||
                    data.year == null && _nameController.text.isEmpty ||
                    _nameController.text == '') {
                  Ui.getSnackBar(
                      title: 'Please Enter a Value', context: context);
                } else {
                  data.addHolidays(
                    context: context,
                      year: data.year,
                      holidayDate: _dateController.text == ''
                          ? data.date
                          : _dateController.text,
                      tittle: _nameController.text);
                }
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

  Future<void> _selectDate(
      BuildContext context, AddHolidayNotifier addHolidayNotifier) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (pickedDate != null) {
      final dateFormate = DateFormat("dd-MM-yyyy").format(pickedDate);
      _dateController.text = DateFormat("dd-MM-yyyy").format(pickedDate);
      addHolidayNotifier.addDate(pickedDate.year.toString(), dateFormate);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    super.dispose();
  }
}
