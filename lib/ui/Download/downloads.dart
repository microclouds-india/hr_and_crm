import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hr_and_crm/ui/view%20pdf/view_pdf.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../repository/DataBase/db.dart';

class Downloads extends StatefulWidget {
  TabController tabController;
  Downloads({required this.tabController});

  @override
  State<Downloads> createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  List<Map<String, Object?>> datas = [];
  bool _load = true;

  getLocalDatabse() async {
    final values = await db.rawQuery('SELECT * FROM Reportdb');
    print(values);
    datas = values;
    setState(() {
      _load = false;
    });
  }

  void openPdf(String path) async {
    final url = Uri.file(path).toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocalDatabse();
  }

  @override
  Widget build(BuildContext context) {
    return _load
        ? Center(
            child: CircularProgressIndicator(
              color: Colors.pink.shade900,
            ),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => openPdf(datas[index]["url"].toString()),
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (context) {
                //   return PdfViewerScreen();
                // })),
                child: ListTile(
                    title: Text(datas[index]["tittle"].toString()),
                    subtitle: Text(datas[index]['subtittle'].toString()),
                    trailing: IconButton(
                        onPressed: () {
                          showAlertDialog(
                              context, datas[index]['id'].toString());
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))),
              );
            },
            itemCount: datas.length,
          );
    ;
  }

  showAlertDialog(BuildContext context, String id) {
    Widget okButton = TextButton(
      child: Text("Ok"),
      onPressed: () {
        setState(() {
          db.delete('Reportdb', where: "id = ?", whereArgs: [id]);
          Navigator.of(context).pop();
          widget.tabController.index = 0;
        });
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Delete"),
      content: Text("Are you sure!"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel')),
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
