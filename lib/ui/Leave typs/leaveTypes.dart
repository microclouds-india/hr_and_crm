import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/provider/providers.dart';
import 'package:hr_and_crm/repository/edit%20and%20delete%20leavetypes/delete%20leavetypes/notifier/notifier.dart';
import 'package:hr_and_crm/repository/edit%20and%20delete%20leavetypes/edit%20leave%20types/notifier/notifier.dart';
import 'package:hr_and_crm/repository/leaveTypes/notifier/leaveTypes.notifier.dart';
import 'package:hr_and_crm/ui/Leave%20typs/addLeavetype.dart';
import 'package:hr_and_crm/ui/Leave%20typs/editleave_typs.dart';
import 'package:provider/provider.dart';

class LeaveTypesScreen extends StatefulWidget {
  const LeaveTypesScreen({Key? key});

  @override
  State<LeaveTypesScreen> createState() => _LeaveTypesScreenState();
}

class _LeaveTypesScreenState extends State<LeaveTypesScreen> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<LeaveTypesNotifier>(context, listen: false);
    final delete= Provider.of<LeaveTypeRemoveNotifier>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        title: apBarText('Leave Types', Colors.white),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: data.getLeaveTypes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.pink.shade900,
              ),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Text('Data Not Available'),
            );
          } else {
            return ListView.builder(
              itemCount: data.leavetypesModel.data.length,
              itemBuilder: (context, index) {
                final leaveType = data.leavetypesModel.data[index];
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(
                      leaveType.leaveType,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                            return EditLeaveTypesScreen(
                              id: leaveType.id,
                              text: leaveType.leaveType,
                            );
                          }));
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete,color: Colors.red,),
                          onPressed: () {
                           Ui.showAlertDialog(context, 'Confirm Delete', 'Are you sure you want to delete this leave type?', ()async{
                            
                            delete.getdata(leaveType.id,context);
                            Navigator.pop(context);
                            setState(() {
                              
                            });
                            
                           }, () {
                            Navigator.pop(context);
                           });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink.shade900,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
            return AddLeaveTypeScreen();
          }));
        },
      ),
    );
  }
}
