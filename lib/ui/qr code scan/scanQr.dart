import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class QRViewWidget extends StatefulWidget {
  @override
  _QRViewWidgetState createState() => _QRViewWidgetState();
}

class _QRViewWidgetState extends State<QRViewWidget> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String scannedData = '';

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 350.0
        : 300.0;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pink.shade900,
        title: apBarText('QR Code Scan Attendance', Colors.white),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              overlay: QrScannerOverlayShape(
                  borderColor: Colors.pink.shade900,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: scanArea),
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      try {
        EasyLoading.show(status: 'Please Wait...');
        var response = await http.get(Uri.parse(scanData.code!));
        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          setState(() {
            scannedData = jsonData["data"][0]["name"];
            if (scannedData.isEmpty) {
              EasyLoading.dismiss();
              Ui.getSnackBar(title: 'This QR not working', context: context);
            }else{
              processAttendanceData(scannedData);
            }
          });
        } else {
          EasyLoading.dismiss();
          Ui.getSnackBar(title: 'This QR not working', context: context);
          Navigator.pop(context);
        }
      } catch (e) {
        EasyLoading.dismiss();
        Navigator.pop(context);
      }
    });
  }

  void processAttendanceData(String data) async {
    // Extract the company ID from the API response
    final response = await http
        .get(Uri.parse('https://cashbes.com/attendance/apis/companies'));
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      final companies = decodedData['data'] as List<dynamic>;
      final company = companies.firstWhere(
        (c) => c['company_name'] == data,
        orElse: () => null,
      );

      if (company != null) {
        final companyId = company['id'].toString();
        await clockInAttendance(companyId);
      } else {
        Ui.getSnackBar(title: 'Company ID not found', context: context);
        EasyLoading.dismiss();
        Navigator.pop(context);
      }
    } else {
     Ui.getSnackBar(title: 'Server Error', context: context);
           EasyLoading.dismiss();
Navigator.pop(context);
    }
  }

  Future<void> clockInAttendance(String companyId) async {
    final prif = await SharedPreferences.getInstance();
    final url =
        Uri.parse('https://cashbes.com/attendance/apis/clockin_qr_attendance');
    final body = {
      'token': prif.getString('token').toString(),
      'company_id': companyId,
    };

    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {

      final decodedData = jsonDecode(response.body);
      Ui.getSnackBar(title: 'Attendance Clock-in Successful', context: context);
      EasyLoading.dismiss();
      Navigator.pop(context);
    } else {
      Ui.getSnackBar(title: 'Attendance Clock-in Faild', context: context);
      EasyLoading.dismiss();
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
