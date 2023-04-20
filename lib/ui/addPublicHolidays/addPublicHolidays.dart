import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';

class PublicHoliday {
  final String name;
  final DateTime date;

  PublicHoliday({required this.name, required this.date});
}

class PublicHolidayScreen extends StatefulWidget {
  @override
  _PublicHolidayScreenState createState() => _PublicHolidayScreenState();
}

class _PublicHolidayScreenState extends State<PublicHolidayScreen> {
  final List<PublicHoliday> publicHolidays = [
    PublicHoliday(name: 'New Year\'s Day', date: DateTime(2023, 1, 1)),
    PublicHoliday(
        name: 'Martin Luther King Jr. Day', date: DateTime(2023, 1, 16)),
    PublicHoliday(name: 'Memorial Day', date: DateTime(2023, 5, 29)),
    PublicHoliday(name: 'Independence Day', date: DateTime(2023, 7, 4)),
    PublicHoliday(name: 'Labor Day', date: DateTime(2023, 9, 4)),
    PublicHoliday(name: 'Thanksgiving Day', date: DateTime(2023, 11, 23)),
    PublicHoliday(name: 'Christmas Day', date: DateTime(2023, 12, 25)),
  ];

  void _addPublicHoliday() async {
    final holidayName = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String? name;
        return AlertDialog(
          title: const Text('New Public Holiday'),
          content: Row(
            children: [
              Expanded(
                child: TextField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'Holiday Name',
                    hintText: 'e.g. Easter Sunday',
                  ),
                  onChanged: (value) {
                    name = value;
                  },
                ),
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('SAVE'),
              onPressed: () {
                Navigator.pop(context, name);
              },
            ),
          ],
        );
      },
    );

    if (holidayName != null) {
      final holidayDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 10),
        lastDate: DateTime(DateTime.now().year + 10),
      );

      if (holidayDate != null) {
        setState(() {
          publicHolidays
              .add(PublicHoliday(name: holidayName, date: holidayDate));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.pink.shade900,
          centerTitle: true,
          title: apBarText('Public Holidays', Colors.white)),
      body: ListView.builder(
        itemCount: publicHolidays.length,
        itemBuilder: (context, index) {
          final publicHoliday = publicHolidays[index];
          return ListTile(
            title: Text(publicHoliday.name),
            subtitle: Text(
                '${publicHoliday.date.day}/${publicHoliday.date.month}/${publicHoliday.date.year}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink.shade900,
        onPressed: _addPublicHoliday,
        tooltip: 'Add Public Holiday',
        child: Icon(Icons.add),
      ),
    );
  }
}
