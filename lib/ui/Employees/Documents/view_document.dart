import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class FileViewer extends StatelessWidget {
  final String file;

  FileViewer({required this.file});

  @override
  Widget build(BuildContext context) {
    if (file.endsWith('.pdf')) {
      return SfPdfViewer.network(file);
    } else if (file.endsWith('.jpg') ||
        file.endsWith('.jpeg') ||
        file.endsWith('.png')) {
      return Image.network(
        file,
        fit: BoxFit.contain,
      );
    } else {
      return Text('Unsupported file format');
    }
  }
}

class DocumentViewScreen extends StatelessWidget {
  String file;
  DocumentViewScreen({required this.file});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: apBarText('Document', Colors.white),
        backgroundColor: Colors.pink.shade900,
        centerTitle: true,
      ),
      body: Center(
        child: FileViewer(file: file),
      ),
    );
  }
}
