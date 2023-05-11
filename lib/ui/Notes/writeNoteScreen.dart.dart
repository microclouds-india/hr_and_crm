import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:http/http.dart' as http;
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/common/widgets/submitContainer.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/widgets/bookingFormTextFields.dart';

class WriteNoteScreen extends StatefulWidget {
  bool morning;
  WriteNoteScreen({required this.morning});

  @override
  State<WriteNoteScreen> createState() => _WriteNoteScreenState();
}

TextEditingController reportController = TextEditingController();

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
    print(widget.morning);
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
              BookingFormTextFields(
                hint: 'Enter your $morningORevening report',
                controller: reportController,
                maxLines: 10,
              ),
              GestureDetector(
                  onTap: () async {
                    if (reportController.text.isEmpty) {
                      Ui.getSnackBar(
                          title: 'Please enter report', context: context);
                    } else {
                      final prif = await SharedPreferences.getInstance();
                      var url = Uri.parse(
                          'https://cashbes.com/attendance/apis/send_workreport');
                      var response = await http.post(url, body: {
                        'token': prif.getString('token'),
                        'report_message': reportController.text,
                        'clock_out': '9:00',
                        'attend_date':
                            DateFormat('dd-MM-yyyy').format(DateTime.now()),
                        'clock_in':
                            DateFormat('HH:mm:ss').format(DateTime.now()),
                      });
                      if (response.statusCode == 200) {
                        print(response.body);
                        Ui.getSnackBar(
                            title: 'Report Posted', context: context);
                      } else {
                        Ui.getSnackBar(title: 'Server Error', context: context);
                      }
                    }
                  },
                  child: submitContainer(context, 'Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
