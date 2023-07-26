import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/repository/employee%20leave%20requisets/notifier/notifier.dart';
import 'package:hr_and_crm/ui/leave%20request/reqestScreen.dart';
import 'package:provider/provider.dart';

class EmployeeLeavRequests extends StatelessWidget {
  const EmployeeLeavRequests ({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<EmployeeLeaveRequistsNotifier>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        title: apBarText('Leave Requests', Colors.white),
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink.shade900,
        onPressed: (){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
          return RequestScreen();
        }));
      },child: Center(
        child: Icon(Icons.add,color: Colors.white,),
      ),),
      body: FutureBuilder(
        future: data.fetchData(),
        builder: (context, snapshot) {
        if (snapshot.connectionState==ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: Colors.pink.shade900,),
          );
        }else if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data!.data.length,
            itemBuilder: (context, index) {
            return Card(child: ListTile(
              trailing: Container(
                color: Colors.yellow,
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(snapshot.data!.data[index].status,style: TextStyle(
                  color: Colors.black
                ),),
              )),
              subtitle: Text(snapshot.data!.data[index].ldate),
              title: Text(snapshot.data!.data[index].reason),));
          },);
        }else{
          return Center(
            child: Text('Data not available'),
          );
        }
      },),
    );
  }
}