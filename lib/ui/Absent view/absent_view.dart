import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/repository/absent_all/notifier/absent_all_notifier.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AbsentViewScreen extends StatelessWidget {
  const AbsentViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<AbsentAllNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        title: apBarText('Absent Employees', Colors.white),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: data.getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.data.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 100,
                      decoration: Ui.getBoxDecoration(),
                      child: ListTile(
                        title: Text(snapshot.data!.data[index].name),
                        subtitle: Text(
                            'Date : ${DateFormat('dd-MM-yyyy').format(snapshot.data!.data[index].attendDate)}'),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(color: Colors.pink.shade900),
              );
            }
          }),
    );
  }
}
