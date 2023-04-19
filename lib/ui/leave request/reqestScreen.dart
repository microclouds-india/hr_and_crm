import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/repository/leaveTypes/notifier/leaveTypes.notifier.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  TextEditingController textEditingController = TextEditingController();
  DateTime fromeDate = DateTime.now();
  DateTime toDate = DateTime.now();
  bool halfLeave = false;
  String dropdownValue = 'Reason 1';
  List<String> options = ['Reason 1', 'Reason 2', 'Reason 3'];
  @override
  Widget build(BuildContext context) {

    final leaveTypesData = Provider.of<LeaveTypesNotifier>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        title: Text(
          "Request Leave",
          style: TextStyle(
              fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'From date', border: OutlineInputBorder()),
                  ),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'To date', border: OutlineInputBorder()),
                  ),
                ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: halfLeave,
                  onChanged: (bool? value) {
                    setState(() {
                      halfLeave = value!;
                    });
                  },
                ),
                Text(
                  'Request Leave for half day',
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
            FutureBuilder(
              future: leaveTypesData.getLeaveTypes(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return leaveTypesData.leavetypesModel.data.isNotEmpty
                      ? Consumer<LeaveTypesNotifier>(builder: (context, data, _) {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(8),
                            padding:
                            const EdgeInsets.only(left: 8, right: 8),
                            decoration: Ui.getBoxDecorationWithoutBorder(),
                            child: DropdownButton(
                              value: leaveTypesData.leaveReason,
                              underline: SizedBox(),
                              iconEnabledColor: Colors.pink.shade900,
                              isExpanded: true,
                              hint: Text(
                                "Reason for Leave",
                                style:
                                const TextStyle(color: Colors.black),
                              ),
                              items: leaveTypesData.leavetypesModel.data
                                  .map(
                                    (map) => DropdownMenuItem(
                                  value: map.id,
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.only(
                                        left: 10.0,
                                        right: 10.0,
                                        top: 15.0,
                                        bottom: 15.0),
                                    // decoration: Ui.getBoxDecorationWithoutBorder(),
                                    child: Text(
                                      map.leaveType,
                                      style: const TextStyle(
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              )
                                  .toList(),
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              onChanged: (value) {
                                leaveTypesData.getLeaveReason(value.toString());
                              },
                            ),
                          ),
                        );
                      })
                      : const Center(child: Text("No items"));
                } else {
                  return Container(
                    margin: EdgeInsets.all(10),
                    child:  CircularProgressIndicator(
                      color: Colors.pink.shade900,
                    ),
                  );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                isExpanded: true,
                value: dropdownValue,
                icon: Icon(Icons.arrow_downward),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: options.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Reason of leave'),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.pink.shade900,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Center(
                  child: Text(
                    'Request Leave',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget datePicker(DateTime dateTime) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: textEditingController.text == ''
            ? 'SelectDate'
            : textEditingController.text,
        hintText: "Ex. Insert your dob",
      ),
      onTap: () async {
        DateTime dateTime = DateTime(1900);
        FocusScope.of(context).requestFocus(FocusNode());

        dateTime = (await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100)))!;

        setState(() {
          textEditingController.text =
              DateFormat('dd-MM-yyyy').format(dateTime);
        });
      },
    );
  }
}
