import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:intl/intl.dart';

class ExpenseDetailsScreen extends StatefulWidget {
  const ExpenseDetailsScreen({super.key});

  @override
  State<ExpenseDetailsScreen> createState() => _ExpenseDetailsScreenState();
}

class _ExpenseDetailsScreenState extends State<ExpenseDetailsScreen> {
  List<String> tittles = ['Room', 'Food', 'Travel'];

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showMyDialog,
        backgroundColor: Colors.pink.shade900,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        title: apBarText('Expense', Colors.white),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: tittles.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tittles[index]),
            subtitle: Text('Balance: 25000'),
            trailing: Text(formattedDate),
          );
        },
      ),
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
                    decoration: InputDecoration(
                        hintText: 'Tittle', border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
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
