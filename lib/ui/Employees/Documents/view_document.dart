import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';

class ViewDocuments extends StatelessWidget {
  const ViewDocuments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit_document,
                color: Colors.white,
              ))
        ],
        title: apBarText('Driving Licence', Colors.white),
        centerTitle: true,
      ),
      body: Column(
        children:const [
          // Image.network('')
        ],
      ),
    );
  }
}
