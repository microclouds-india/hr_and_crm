import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/branches/notifier/branches.notifier.dart';
import 'package:provider/provider.dart';

class Branches extends StatefulWidget {
  const Branches({Key? key}) : super(key: key);

  @override
  State<Branches> createState() => _BranchesState();
}

class _BranchesState extends State<Branches> {
  @override
  Widget build(BuildContext context) {
    final branchData = Provider.of<BranchesNotifier>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.of(context).pushNamed("/addBranches");
        },
        label: const Text(
          'Add Branch',
          style: TextStyle(color: Colors.black),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            "Branches",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: FutureBuilder(
          future: branchData.getBranches(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (branchData.branchesModel.data.isNotEmpty) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Consumer<BranchesNotifier>(builder: (context, data, _) {
                        return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: branchData.branchesModel.data.length,
                            itemBuilder: (context, index) {
                              return ListTile(
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
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                title: Text(
                                  branchData
                                      .branchesModel.data[index].branchName,
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                subtitle: Text(branchData
                                    .branchesModel.data[index].address),
                                trailing: const Icon(Icons.more_horiz),
                              );
                            });
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 2,
                        color: Colors.grey.shade300,
                      ),
                    ],
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
