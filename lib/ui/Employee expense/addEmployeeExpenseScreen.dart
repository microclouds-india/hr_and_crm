import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/common/widgets/bookingFormTextFields.dart';
import 'package:hr_and_crm/common/widgets/submitContainer.dart';
import 'package:hr_and_crm/ui/add%20expense/notifier/notifier.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddEmployeeExpenseScreen extends StatefulWidget {
  @override
  _AddEmployeeExpenseScreenState createState() =>
      _AddEmployeeExpenseScreenState();
}

class _AddEmployeeExpenseScreenState extends State<AddEmployeeExpenseScreen> {
  String? _selectedEmployee;
  DateTime? _selectedDate;
  final _expenseTimeController = TextEditingController();
  final _expenseTypeController = TextEditingController();
  final _expenseAmountController = TextEditingController();

  @override
  void dispose() {
    _expenseTypeController.dispose();
    _expenseAmountController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Widget _expenseTypeDrpdown() {
    return DropdownButtonFormField<String>(
      value: _selectedEmployee,
      onChanged: (String? value) {
        setState(() {
          _selectedEmployee = value;
        });
      },
      decoration: InputDecoration(
        labelText: 'Employee',
        border: OutlineInputBorder(),
      ),
      items: <String>[
        'Employee 1',
        'Employee 2',
        'Employee 3',
        'Employee 4',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildExpenseAmountTextField() {
    return BookingFormTextFields(
      controller: _expenseAmountController,
      keyboardType: TextInputType.number,
      hint: 'Expense Amount',
      iconData: Icons.money,
    );
  }

  Widget _buildDatePicker() {
    return InkWell(
      onTap: () {
        _selectDate(context);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Expense Date',
          border: OutlineInputBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              _selectedDate != null
                  ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                  : 'Select Date',
            ),
            Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }

  List<Employee> employees = [];
  Employee? selectedEmployee;
  List<ExpenseCategory> categories = [];
  ExpenseCategory? selectedCategory;

  bool _load = true;

  @override
  void initState() {
    super.initState();
    fetchEmployees();
    fetchExpenseCategories();
  }

  Future<void> fetchExpenseCategories() async {
    final url =
        Uri.parse('https://cashbes.com/attendance/apis/expense_categories');
    final token = '50168793323946464646464';

    try {
      final response = await http.post(url, body: {'token': token});
      final jsonData = json.decode(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonData['data'];
        categories =
            data.map((item) => ExpenseCategory.fromJson(item)).toList();
        setState(() {
          _load = false;
        });
      } else {
        // Handle error if needed
        print('API request failed with status code ${response.statusCode}');
      }
    } catch (error) {
      // Handle error
      print('Error: $error');
    }
  }

  fetchEmployees() async {
    final url = Uri.parse('https://cashbes.com/attendance/apis/employees');
    final token = '3168715691146464646464';

    try {
      final response = await http.post(url, body: {'token': token});
      final jsonData = json.decode(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonData['data'];
        employees = data.map((item) => Employee.fromJson(item)).toList();
        setState(() {});
      } else {
        // Handle error if needed
        print('API request failed with status code ${response.statusCode}');
      }
    } catch (error) {
      // Handle error
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final data =
        Provider.of<AddEmployeeExpenseNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        title: apBarText('Add Expense', Colors.white),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _load
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : DropdownButtonFormField<Employee>(
                    decoration: const InputDecoration(
                      labelText: 'Select Employee',
                      border: OutlineInputBorder(),
                    ),
                    value: selectedEmployee,
                    items: employees.map((Employee employee) {
                      return DropdownMenuItem<Employee>(
                        value: employee,
                        key: Key(employee
                            .id), // Add a unique identifier based on employee ID
                        child: Text(employee.name),
                      );
                    }).toList(),
                    onChanged: (Employee? employee) {
                      setState(() {
                        selectedEmployee = employee;
                      });
                      print('dddddddddddddddddd${selectedEmployee!.id}');
                    },
                    hint: Text('Select an employee'),
                  ),
            SizedBox(height: 16.0),
            _buildDatePicker(),
            SizedBox(height: 16.0),
            _load
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.pink.shade900,
                    ),
                  )
                : DropdownButtonFormField<ExpenseCategory>(
                    decoration: const InputDecoration(
                      labelText: 'Employee',
                      border: OutlineInputBorder(),
                    ),
                    value: selectedCategory,
                    items: categories.map((ExpenseCategory category) {
                      return DropdownMenuItem<ExpenseCategory>(
                        value: category,
                        key: Key(category.id),
                        child: Text(category.expCategory),
                      );
                    }).toList(),
                    onChanged: (ExpenseCategory? category) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    hint: Text('Select an expense category'),
                  ),
            SizedBox(height: 16.0),
            _buildExpenseAmountTextField(),
            SizedBox(height: 16.0),
            GestureDetector(
                onTap: () {
                  if (selectedEmployee!.id.isEmpty &&
                      _selectedDate == null &&
                      selectedCategory!.expCategory.isEmpty &&
                      _expenseAmountController.text.isEmpty) {
                    Ui.getSnackBar(
                        title: 'Please Add Values', context: context);
                  } else {
                    print(DateFormat('dd-mm-yyyy').format(_selectedDate!));
                    data.addExpense(
                        selectedEmployee!.id,
                        DateFormat('dd-mm-yyyy').format(_selectedDate!),
                        selectedCategory!.expCategory,
                        _expenseAmountController.text,
                        context);
                  }
                },
                child: submitContainer(context, 'Submit'))
          ],
        ),
      ),
    );
  }
}

class Employee {
  final String id;
  final String name;

  Employee({required this.id, required this.name});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'].toString(),
      name: json['name'],
    );
  }
}

class ExpenseCategory {
  final String id;
  final String expCategory;

  ExpenseCategory({required this.id, required this.expCategory});

  factory ExpenseCategory.fromJson(Map<String, dynamic> json) {
    return ExpenseCategory(
      id: json['id'].toString(),
      expCategory: json['exp_category'],
    );
  }
}
