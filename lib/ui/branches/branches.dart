import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/repository/branches/notifier/branches.notifier.dart';
import 'package:hr_and_crm/ui/Edit%20Branch/editBranchScreen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Branches extends StatefulWidget {
  const Branches({Key? key}) : super(key: key);

  @override
  State<Branches> createState() => _BranchesState();
}
enum SampleItem { edit , delete }

class _BranchesState extends State<Branches> {
  SampleItem? selectedMenu;
  
  
  @override
  Widget build(BuildContext context) {
    final branchData = Provider.of<BranchesNotifier>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.pink.shade900,
        onPressed: () {
          Navigator.of(context).pushReplacementNamed("/addBranches");
        },
        label: const Text(
          'Add Branch',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Branches",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
          future: branchData.getBranches(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (branchData.branchesModel.data.isNotEmpty) {
                return Container(
                  margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: ListView.builder(
                    itemCount: branchData.branchesModel.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                            leading: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                    //color of border
                                    width: 2, //width of border
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Radius For",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    Text(
                                      " Attendance",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    Text(
                                      "30 M",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            title: Text(
                              branchData.branchesModel.data[index].branchName,
                              style: TextStyle(
                                  color: Colors.pink.shade900,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            subtitle: Text(
                                branchData.branchesModel.data[index].address),
                            trailing: PopupMenuButton<SampleItem>(
                          initialValue: selectedMenu,
                          // Callback that sets the selected popup menu item.
                          onSelected: (SampleItem item) {
                            setState(() {
                              selectedMenu = item;
                            });
                            if (item == SampleItem.delete) {
                              
                              Ui.showAlertDialog(context, 'Confirmation', 'Are you sure you want to remove this branch?', ()async{
                                      try {
                                        EasyLoading.show(status: 'Please Wait...');
                                        var response = await http.post(Uri.parse('https://cashbes.com/attendance/apis/branches_remove'),body: {
                                          'id':branchData.branchesModel.data[index].id,
                                        });
                                        setState(() {
                                          
                                        });
                                        EasyLoading.dismiss();
                                        Navigator.of(context).pop();
                                      } catch (e) {
                                        EasyLoading.dismiss();
                                        Ui.getSnackBar(title: 'Server Error', context: context);
                                      }
                               }, () {
                                      Navigator.of(context).pop();
                               });
                            }else{
                               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                              return EditBranchScreen(
                                      id: branchData.branchesModel.data[index].id,
                                      address: branchData.branchesModel.data[index].address,
                                      branchName: branchData.branchesModel.data[index].branchName,
                              );
                            }));
                            }
                          },
                          itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
                            const PopupMenuItem<SampleItem>(
                              value: SampleItem.edit,
                              child: Text('Edit Branch'),
                            ),
                            const PopupMenuItem<SampleItem>(
                              value: SampleItem.delete,
                              child: Text('Delete'),
                            ),
                            
                          ],
                        ),
                                          ),
                      );
                    },
                  ),
                );
              } else {
                return const Center(
                  child: Text("No data"),
                );
              }
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Something went wrong"),
              );
            }
            return Center(
                child: CircularProgressIndicator(color: Colors.pink.shade700));
          }),
    );
  }
}
