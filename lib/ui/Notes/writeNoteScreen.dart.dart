import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/common/widgets/submitContainer.dart';

class WriteNoteScreen extends StatefulWidget {
  bool morning;
  WriteNoteScreen({required this.morning});

  @override
  State<WriteNoteScreen> createState() => _WriteNoteScreenState();
}

class _WriteNoteScreenState extends State<WriteNoteScreen> {
  String? morningORevening = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String morningORevening = widget.morning ? 'morning' : 'evening';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        title: apBarText('New Report', Colors.white),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                maxLines: 20,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your $morningORevening report',
                ),
              ),
              submitContainer(context, 'Submit')
            ],
          ),
        ),
      ),
    );
  }
}
