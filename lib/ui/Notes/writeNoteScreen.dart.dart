import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/ui/hr%20work%20reports/deatails.dart';
import 'package:hr_and_crm/ui/hr%20work%20reports/workReposts.dart';
import 'package:http/http.dart' as http;
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/common/widgets/submitContainer.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/widgets/bookingFormTextFields.dart';

class WriteNoteScreen extends StatefulWidget {



  @override
  State<WriteNoteScreen> createState() => _WriteNoteScreenState();
}

TextEditingController reportController = TextEditingController();
TextEditingController titleController = TextEditingController();

class _WriteNoteScreenState extends State<WriteNoteScreen> {


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
          return DailyReportListScreen(
            
          );
        }));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
          return DailyReportListScreen(
        
          );
        }));
          }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
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
                  iconData: Icons.notes,
                  hint: 'Enter your title',
                  controller: titleController,
                  maxLines: 100,
                ),
                SizedBox(height: 10,),
                 BookingFormTextFields(
                  iconData: Icons.notes,
                  hint: 'Enter your report',
                  controller: reportController,
                  maxLines: 100,
                ),
                GestureDetector(
                    onTap: () async {
                      if (reportController.text.isEmpty&&titleController.text.isEmpty) {
                        Ui.getSnackBar(
                            title: 'Please enter report', context: context);
                      } else {
                        final prif = await SharedPreferences.getInstance();
                        var url = Uri.parse(
                            'https://cashbes.com/attendance/apis/send_workreport');
                        var response = await http.post(url, body: {
                          'token': prif.getString('token'),
                          'report_message': reportController.text,
                          'title':titleController.text
                        });
                        if (response.statusCode == 200) {
                          print(response.body);
                          Ui.getSnackBar(
                              title: 'Report Posted', context: context);
                               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
          return DailyReportListScreen(
           
          );
        }));
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
      ),
    );
  }
}
