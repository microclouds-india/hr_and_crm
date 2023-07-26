// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:hr_and_crm/common/ui.dart';
// import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
// import 'package:hr_and_crm/repository/clock_in/clock_in_notifier/clock_IN_notifier.dart';
// import 'package:hr_and_crm/repository/clock_out/notifier/clock_OUT_notifier.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class PunchInAttendance extends StatefulWidget {
//   String token;
//   PunchInAttendance({required this.token});

//   @override
//   State<PunchInAttendance> createState() => _PunchInAttendanceState();
// }

// class _PunchInAttendanceState extends State<PunchInAttendance> {
//   late ClockinviewModel clockinviewModel;

//   @override
//   Widget build(BuildContext context) {
//     final data = Provider.of<ClockINNotifier>(context, listen: false);
//     final clockOut = Provider.of<ClockOUTNotifier>(context, listen: false);
//     return Scaffold(
//         // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//         // floatingActionButton: FloatingActionButton(
//         //   onPressed: () {
//         //     _addAttendace(data, context);
//         //   },
//         //   backgroundColor: Colors.pink.shade900,
//         //   child: Center(
//         //     child: Icon(
//         //       Icons.login,
//         //       color: Colors.white,
//         //     ),
//         //   ),
//         // ),
//         appBar: AppBar(
//           title: apBarText('Punch in Attendance', Colors.white),
//           backgroundColor: Colors.pink.shade900,
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 DateFormat('h:mm a').format(DateTime.now()).toString(),
//                 style: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Visibility(visible: false, child: Text('Clock IN Time:9:00')),
//               SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       _addAttendace(data, context);
//                     },
//                     child: Container(
//                         height: 100,
//                         width: 100,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(10)),
//                             border: Border.all(color: Colors.blueGrey)),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: const [
//                             Icon(
//                               Icons.login,
//                               color: Colors.green,
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Text('Clock IN')
//                           ],
//                         )),
//                   ),
//                   GestureDetector(
//                     onTap: () async {
//                       await EasyLoading.show(
//                         status: 'loading...',
//                         maskType: EasyLoadingMaskType.black,
//                       );
//                       var response = await http.post(
//                           Uri.parse(
//                               'https://cashbes.com/attendance/apis/clock_in_view'),
//                           body: {'token': widget.token});
//                       if (response.statusCode == 200) {
//                         var json = jsonDecode(response.body);
//                         clockinviewModel = ClockinviewModel.fromJson(json);
//                         EasyLoading.dismiss();
//                         setState(() {});
//                       } else {
//                         EasyLoading.dismiss();
//                         Ui.getSnackBar(title: 'Server Issue', context: context);
//                       }
//                       if (DateFormat('yyyyy.MMMMM.dd').format(
//                                   clockinviewModel.data.last.attendDate) ==
//                               DateFormat('yyyyy.MMMMM.dd')
//                                   .format(DateTime.now()) ||
//                           clockinviewModel == null) {
//                         _clockOuT(
//                             clockOut,
//                             clockinviewModel.data.last.clockIn,
//                             '',
//                             DateFormat('yyyyy.MMMMM.dd')
//                                 .format(clockinviewModel.data.last.attendDate),
//                             clockinviewModel.data.last.id);
//                       } else {
//                         Ui.getSnackBar(
//                             title: 'You have not marked attendance today!',
//                             context: context);
//                       }
//                     },
//                     child: Container(
//                       height: 100,
//                       width: 100,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                           border: Border.all(color: Colors.blueGrey)),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.logout,
//                             color: Colors.red,
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Text('Clock OUT')
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ));
//   }

//   Future<void> _addAttendace(
//     ClockINNotifier notifier,
//     BuildContext ctx,
//   ) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Attendance Mark'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: const <Widget>[
//                 Text('Mark your attendance'),
//                 Text('Would you like to approve of this message?'),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: const Text('Attendance Mark'),
//               onPressed: () async {
//                 final prif = await SharedPreferences.getInstance();
//                 notifier.clockIN(
//                     DateFormat('yyyyy.MMMMM.dd')
//                         .format(DateTime.now())
//                         .toString(),
//                     DateFormat('h:mm a').format(DateTime.now()),
//                     prif.getString('token')!,
//                     ctx);
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> _clockOuT(ClockOUTNotifier clockOUTNotifier, String clockin,
//       String clockOUTtime, String attendaceDate, String id) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Close Attendance'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text('Time : ${clockin}'),
//                 Text('Date  : ${attendaceDate}'),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Close your attendance'),
//               onPressed: () async {
//                 await EasyLoading.show(
//                   status: 'loading...',
//                   maskType: EasyLoadingMaskType.black,
//                 );
//                 final prif = await SharedPreferences.getInstance();
//                 var headers = {
//                   'Cookie':
//                       'ci_session=36398b9655d722ceb3e5de694344ef71d6036172'
//                 };
//                 var request = http.MultipartRequest('POST',
//                     Uri.parse('https://cashbes.com/attendance/apis/clock_out'));
//                 request.fields.addAll({
//                   'token': widget.token,
//                   'id': id,
//                   'clock_out': clockOUTtime,
//                   'attend_date': '2023-04-20',
//                   'clock_in': '09:00'
//                 });

//                 request.headers.addAll(headers);

//                 http.StreamedResponse response = await request.send();

//                 if (response.statusCode == 200) {
//                   print(await response.stream.bytesToString());

//                   EasyLoading.dismiss();
//                   Navigator.of(context).pop();
//                 } else {
//                   EasyLoading.dismiss();
//                   print(response.reasonPhrase);
//                 }
//               },
//             ),
//             TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('Close')),
//           ],
//         );
//       },
//     );
//   }
// }
