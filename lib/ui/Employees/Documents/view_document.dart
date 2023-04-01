import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';

class ViewDocuments extends StatelessWidget {
  String documentName;
  ViewDocuments({required this.documentName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink.shade900,
        onPressed: () {},
        child: const Center(
          child: Icon(
            Icons.upload,
            color: Colors.white,
          ),
        ),
      ),
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
        title: apBarText(documentName, Colors.white),
        centerTitle: true,
      ),
      body: Column(
        children: const [
          // Image.network('')
        ],
      ),
    );
  }
}
