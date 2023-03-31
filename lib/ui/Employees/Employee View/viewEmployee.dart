import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/widgets/appbarTXT.dart';

class ViewEmployee extends StatefulWidget {
  const ViewEmployee({super.key});

  @override
  State<ViewEmployee> createState() => _ViewEmployeeState();
}

class _ViewEmployeeState extends State<ViewEmployee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        title: apBarText('Username', Colors.white),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: SingleChildScrollView(
          child: Column(children: [
            imageRow(),
            Divider(
              thickness: 0.2,
              color: Colors.grey,
            ),
            userDeatails('Employee ID', '112'),
            userDeatails('Phone', '0987654321'),
            userDeatails('Email', 'abc@gmail.com'),
            userDeatails('Birthday', '1995-12-19'),
            userDeatails('Gender', 'Male'),
            ListTile(
              title: Text(
                'Address',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                  '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'''),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: () async {
                        await launchUrl(Uri.parse(
                            'https://wa.me/916238116239?text=Hello"'));
                      },
                      child: shareIMG('assets/icons/whatsapp.png')),
                  shareIMG('assets/icons/gmail (1).png'),
                  shareIMG('assets/icons/phone-call.png')
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  Image shareIMG(String img) {
    return Image(
      height: 20,
      width: 20,
      image: AssetImage(img),
      fit: BoxFit.cover,
    );
  }

  Column userDeatails(String tittle, String trailling) {
    return Column(
      children: [
        ListTile(
          title: Text(
            tittle,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          trailing: Text(
            trailling,
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Divider(
          thickness: 0.1,
          color: Colors.grey,
        ),
      ],
    );
  }

  Column imageRow() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'assets/icons/logo.png',
                  height: 150.0,
                  width: 150.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        apBarText('Username', Colors.black),
        SizedBox(
          height: 20,
        ),
        Text('Web Developer')
      ],
    );
  }
}
