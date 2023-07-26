// import 'package:flutter/material.dart';
// import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
// import 'package:hr_and_crm/ui/hr%20work%20reports/workReposts.dart';

// class DailyReportDetails extends StatelessWidget {
//   final DailyReport report;

//   DailyReportDetails({required this.report});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: apBarText('Report Details', Colors.white),
//         centerTitle: true,
//         backgroundColor: Colors.pink.shade900,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               report.title,
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 16),
//             Text(
//               report.date,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey,
//               ),
//             ),
//             SizedBox(height: 16),
//             Text(
//               report.description,
//               style: TextStyle(fontSize: 18),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }