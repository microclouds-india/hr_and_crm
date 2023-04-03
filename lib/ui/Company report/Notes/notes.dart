import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';

class CompanyNotesScreen extends StatefulWidget {
  const CompanyNotesScreen({super.key});

  @override
  State<CompanyNotesScreen> createState() => _CompanyNotesScreenState();
}

class _CompanyNotesScreenState extends State<CompanyNotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        title: apBarText('Notes', Colors.white),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              'Tittle',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'abcedfghijklmnopqrstuvwxyz',
              style: TextStyle(overflow: TextOverflow.ellipsis),
            ),
            trailing: Text(
              '${DateTime.now().hour}:${DateTime.now().minute}',
              style: TextStyle(overflow: TextOverflow.ellipsis),
            ),
          );
        },
      ),
    );
  }
}
