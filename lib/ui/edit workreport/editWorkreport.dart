import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/common/widgets/bookingFormTextFields.dart';
import 'package:hr_and_crm/common/widgets/submitContainer.dart';

class WorkReportEditScreen extends StatefulWidget {
  String message;
  String title;
  WorkReportEditScreen({required  this.message,required this.title});

  @override
  State<WorkReportEditScreen> createState() => _WorkReportEditScreenState();
}

class _WorkReportEditScreenState extends State<WorkReportEditScreen> {

final TextEditingController _titleController = TextEditingController();
TextEditingController _reportController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController.text = widget.title;
    _reportController.text= widget.message;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        title: apBarText('Edit Work Report', Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 16.0),
            Text(
              'Edit Report Message',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            BookingFormTextFields(
              hint: 'Title',
              iconData: Icons.notes,
              controller: _titleController,
              // TODO: Add logic to save the edited title
            ),
            SizedBox(height: 16.0),
            BookingFormTextFields(iconData: Icons.notes, hint: 'Report ',controller: _reportController,),
            SizedBox(height: 16.0),
            submitContainer(context, 'Save')
          ],
        ),
      ),
    );
  }
}

