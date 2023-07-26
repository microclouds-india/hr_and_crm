// ignore: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/repository/employee%20expense%20view/model.dart';
import 'package:hr_and_crm/ui/Employee%20expense/addEmployeeExpenseScreen.dart';
import 'package:hr_and_crm/ui/employee%20management/employeeManagement.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class EmployeeExpenseScreen extends StatefulWidget {
  const EmployeeExpenseScreen({super.key});

  @override
  State<EmployeeExpenseScreen> createState() => _EmployeeExpenseScreenState();
}

class _EmployeeExpenseScreenState extends State<EmployeeExpenseScreen> {

late EmployeeExpenseViewModel _model;
late List type =[];
late List amount =[];

Future <EmployeeExpenseViewModel> getData()async{
  try {
    final prif = await SharedPreferences.getInstance();
    var endPoint ='https://cashbes.com/attendance/apis/employee_expenses';
    var response = await http.get(Uri.parse(endPoint));
    if (response.statusCode==200) {
      var json = jsonDecode(response.body);
      _model = EmployeeExpenseViewModel.fromJson(json);
      // ignore: avoid_function_literals_in_foreach_calls
      _model.data.forEach((element) { 
        if (element.employeeId== prif.getString('MyId')) {
          type.add(element.expType);
          amount.add(element.expAmount);
        }
      });
    }
  } catch (e) {
    Ui.getSnackBar(title: 'Server Error', context: context);
  }
  return _model;
}

@override
  void dispose() {
    super.dispose();
    type.clear();
    amount.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink.shade900,
        onPressed: (){
          Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return  AddEmployeeExpenseScreen();
                }));
        },child: const Center(
        child: Icon(Icons.add,color: Colors.white,),
      ),),
      appBar: AppBar(backgroundColor: Colors.pink.shade900,
      title: apBarText('Employee Expence', Colors.white),
      centerTitle: true,
     
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context,snapshot) {
         if (snapshot.connectionState == ConnectionState.waiting) {
           return Center(
            child: CircularProgressIndicator(
              color: Colors.pink.shade900,
            ),
           );
         }else if(!snapshot.hasData){
          return const Center(
            child: Text('Data Not Available')
          );
         }else {
           return ListView.builder(
            itemCount: type.length,
            itemBuilder: (context, index) {
            return Ui.card(type[index], 'Expense: ${amount[index]}');
          },);
         }
        }
      ),
    );
  }
}