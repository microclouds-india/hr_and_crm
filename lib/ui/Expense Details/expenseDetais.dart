import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/ui/Employee%20expense/addEmployeeExpenseScreen.dart';
import 'package:hr_and_crm/ui/Expense%20Details/model/allModel.dart';
import 'package:hr_and_crm/ui/Expense%20Details/model/model.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseDetailsScreen extends StatefulWidget {
  bool hr;
  ExpenseDetailsScreen({required this.hr});

  @override
  State<ExpenseDetailsScreen> createState() => _ExpenseDetailsScreenState();
}

class _ExpenseDetailsScreenState extends State<ExpenseDetailsScreen> {
 
  late EmployeeExpenseModel _model;
  late EmployeeExpenseModelAll _modelAll;

  _getDate() async {
    try {
      final prif = await SharedPreferences.getInstance();
      var response = await http.post(
          Uri.parse('https://cashbes.com/attendance/apis/employee_expenses'),
          body: {
            'token': prif.getString('token'),
          }
          );
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        _model = EmployeeExpenseModel.fromJson(json);
      }
    } catch (e) {
      Ui.getSnackBar(title: 'Datas Not Available', context: context);
    }
    return _model;
  }

  _getAllEmployeesExpense() async {
     try {
      final prif = await SharedPreferences.getInstance();
      var response = await http.post(
          Uri.parse('https://cashbes.com/attendance/apis/employee_expenses'),
          
          );
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        _model = EmployeeExpenseModel.fromJson(json);
      }
    } catch (e) {
      Ui.getSnackBar(title: 'Datas Not Available', context: context);
    }
    return _model;
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
          return AddEmployeeExpenseScreen();
        }));
        },
        backgroundColor: Colors.pink.shade900,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        title: apBarText('Expense', Colors.white),
        centerTitle: true,
      ),
      body:widget.hr? FutureBuilder(
          future: _getAllEmployeesExpense(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.pink.shade900,
                ),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: _model.data.length,
                itemBuilder: (context, index) {
                  return Padding(
        padding: EdgeInsets.all(5.0),
        child: Card(
          elevation: 4,
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Employee Name: ${_model.data[index].employeeName}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Company Name: company name',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Expense Type: ${_model.data[index].expType}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Expense Amount: ${_model.data[index].expAmount}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Date: ${_model.data[index].expDate}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Branch Name: Branch Name',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      );
                },
              );
            } else {
              return Center(
                child: Text('Empty'),
              );
            }
          }):FutureBuilder(
          future: _getDate(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.pink.shade900,
                ),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: _model.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    shadowColor: Colors.black38,
                    child: ListTile(
                      title: Text(_model.data[index].employeeName),
                      subtitle:
                          Text('${_model.data[index].expType}: ${_model.data[index].expAmount}'),
                      trailing: Text(_model.data[index].expDate),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text('Empty'),
              );
            }
          }),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Expense'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'Tittle', border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: 'Expense', border: OutlineInputBorder()),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.pink.shade900),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Save',
                style: TextStyle(color: Colors.pink.shade900),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
