import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';

import '../../common/widgets/bookingFormTextFields.dart';

// ignore: use_key_in_widget_constructors
class SalaryCalculator extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SalaryCalculatorState createState() => _SalaryCalculatorState();
}

class _SalaryCalculatorState extends State<SalaryCalculator> {
  TextEditingController hourlyRateController = TextEditingController();
  TextEditingController hoursPreWeek = TextEditingController();
  TextEditingController weeksPreYear = TextEditingController();

  double _hourlyRate = 0.0;
  int _hoursPerWeek = 0;
  int _weeksPerYear = 0;
  double _salary = 0.0;

  void _calculateSalary() {
    _hourlyRate = double.tryParse(hourlyRateController.text) ?? 0.0;
    _hoursPerWeek = int.tryParse(hoursPreWeek.text) ?? 0;
    _weeksPerYear = int.tryParse(weeksPreYear.text) ?? 0;
    setState(() {
      _salary = _hourlyRate * _hoursPerWeek * _weeksPerYear;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.pink.shade900,
        title: apBarText('Salary Calculator', Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookingFormTextFields(
                keyboardType: TextInputType.phone,
                controller: hourlyRateController,
                hint: 'Hourly rate!',
                maxLines: 1,
              ),
              BookingFormTextFields(
                keyboardType: TextInputType.phone,
                controller: hoursPreWeek,
                hint: 'Hours per week!',
                maxLines: 1,
              ),
              BookingFormTextFields(
                keyboardType: TextInputType.phone,
                controller: weeksPreYear,
                hint: 'Weeks per year',
                maxLines: 1,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: _calculateSalary,
                child: const Text('Calculate Salary'),
              ),
              const SizedBox(height: 16.0),
              Text('Salary: $_salary'),
            ],
          ),
        ),
      ),
    );
  }
}
