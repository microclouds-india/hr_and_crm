import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/ui/Employees/Add%20Employees/addEmployee.dart';
import 'package:http/http.dart' as http;
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/common/widgets/bookingFormTextFields.dart';
import 'package:hr_and_crm/common/widgets/submitContainer.dart';
import 'package:intl/intl.dart';

class AddAbsentScreen extends StatefulWidget {
  String name;
  String id;
  AddAbsentScreen({required this.id, required this.name});
  @override
  _AddAbsentScreenState createState() => _AddAbsentScreenState();
}

class _AddAbsentScreenState extends State<AddAbsentScreen> {
  TextEditingController _attendDateController = TextEditingController();
  TextEditingController _employeeNameController = TextEditingController();
  String? _selectedStatus;
  List<String> _statusOptions = ['Absent', 'Late', 'Sick'];

  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _employeeNameController.text = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    final format = DateFormat('yyyy-MM-dd');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        centerTitle: true,
        title: apBarText('Add Absent', Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: BookingFormTextFields(
                  iconData: Icons.calendar_month,
                  hint: 'Attent Date',
                  controller: TextEditingController(
                    text: _selectedDate != null
                        ? format.format(_selectedDate!)
                        : 'Attend Date',
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            BookingFormTextFields(
              iconData: Icons.person,
              hint: 'Employee Name',
              controller: _employeeNameController,
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField(
              value: _selectedStatus,
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value!;
                });
              },
              items: _statusOptions.map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Status',
              ),
            ),
            Spacer(),
            GestureDetector(
                onTap: () async {
                  if (_selectedDate == null ||
                      _employeeNameController.text.isEmpty ||
                      _selectedStatus == 'Status') {
                    Ui.getSnackBar(
                        title: 'Please enter values', context: context);
                  } else {
                    var response = await http.post(
                        Uri.parse(
                            'https://cashbes.com/attendance/apis/add_absent'),
                        body: {
                          'employee_id': widget.id,
                          'leave_reason': _selectedStatus
                        });
                    if (response.statusCode == 200) {
                      print(response.body);
                      Ui.getSnackBar(title: 'Attend Marked', context: context);
                    } else {
                      Ui.getSnackBar(
                          title: 'Attend Not marked', context: context);
                    }
                  }
                },
                child: submitContainer(context, 'Submit')),
          ],
        ),
      ),
    );
  }
}
