import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/repository/dropDownServices/dropDownServices.notifier.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodePunchIn extends StatefulWidget {
  const QrCodePunchIn({Key? key}) : super(key: key);

  @override
  State<QrCodePunchIn> createState() => _QrCodePunchInState();
}

class _QrCodePunchInState extends State<QrCodePunchIn> {
  @override
  Widget build(BuildContext context) {

    final dropDownServiceData = Provider.of<DropDownServiceNotifier>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "QR Code Punch In",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              width: double.infinity,
              child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Search for a branch",
                  prefixIcon: const Icon(Icons.search),
                  fillColor: Colors.grey.shade50,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.shade100, width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            Consumer<DropDownServiceNotifier>(builder: (context, data, _) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                margin: const EdgeInsets.all(10.0),
                decoration: Ui.getBoxDecoration(),
                child: DropdownButton<String>(
                  isExpanded: true,
                  underline: const SizedBox(),
                  value: dropDownServiceData.selectedAddress,
                  items: dropDownServiceData.addressDropDownList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    dropDownServiceData.setAddressValue(value.toString());
                  },
                ),
              );
            }),
            const SizedBox(
              height: 30.0,
            ),
            Align(
              alignment: Alignment.center,
              child: QrImage(
                data: 'This is a simple QR code',
                version: QrVersions.auto,
                size: 150,
                gapless: false,
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink.shade700,
                ),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Icon(
                      Icons.qr_code_2_outlined,
                      size: 25,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Generate QR code",
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

}
