import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_and_crm/common/widgets/bookingFormTextFields.dart';

class AddBiometric extends StatefulWidget {
  const AddBiometric({Key? key}) : super(key: key);

  @override
  State<AddBiometric> createState() => _AddBiometricState();
}

class _AddBiometricState extends State<AddBiometric> {
  TextEditingController nameController = TextEditingController();
  TextEditingController serialController = TextEditingController();
  TextEditingController deviceBrandController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    serialController.dispose();
    deviceBrandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Add Biometric",
          style: TextStyle(color: Colors.white),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.pink.shade900),
          height: kBottomNavigationBarHeight - 5,
          width: double.infinity,
          child: Center(
            child: Text(
              "Add Devices",
              style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).pushNamed("/qrCodePunchIn");
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                BookingFormTextFields(
                  iconData: Icons.person,
                  keyboardType: TextInputType.phone,
                  controller: nameController,
                  hint: 'Name',
                  maxLines: 1,
                ),
                const SizedBox(height: 20.0),
                BookingFormTextFields(
                  iconData: Icons.psychology_alt_sharp,
                  suffixIcon: Icon(
                    Icons.qr_code_2_outlined,
                    color: Colors.pink.shade900,
                  ),
                  keyboardType: TextInputType.phone,
                  controller: serialController,
                  hint: 'Serial Number',
                  maxLines: 1,
                ),
                const SizedBox(height: 20.0),
                BookingFormTextFields(
                  iconData: Icons.person,
                  suffixIcon: const Icon(Icons.arrow_drop_down),
                  keyboardType: TextInputType.phone,
                  controller: deviceBrandController,
                  hint: 'Device Brand',
                  maxLines: 1,
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
