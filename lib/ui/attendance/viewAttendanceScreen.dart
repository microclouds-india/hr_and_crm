import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:intl/intl.dart';

class ViewAttendance extends StatefulWidget {
  const ViewAttendance({super.key});

  @override
  State<ViewAttendance> createState() => _ViewAttendanceState();
}

class _ViewAttendanceState extends State<ViewAttendance> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate == null ? DateTime.now() : _selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  List<Color> backgroundColor = [
    const Color(0xffCCFFCC),
    const Color(0xffFFFFCC),
    const Color(0xffFFCCCC),
    const Color(0xffFFFFCC),
    const Color(0xffFFCCFF)
  ];
  List<String> leave = ['Presend', 'Late', 'Absent', 'Half Day', 'Paid Leave'];
  List<Color> textClr = [
    Colors.green,
    Colors.yellow,
    Colors.pink,
    Colors.yellow,
    Colors.purple
  ];
  @override
  Widget build(BuildContext context) {
    String viewDate = DateFormat('MMMM dd').format(_selectedDate);
    return Scaffold(
      appBar: AppBar(
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
        actions: [
          TextButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.download,
                color: Colors.white,
              ),
              label: const Text(
                'Download',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10),
              ))
        ],
        backgroundColor: Colors.pink.shade900,
        centerTitle: true,
        title: apBarText('Attendance', Colors.white),
        elevation: 0,
      ),
      body: Column(children: [
        Container(
          color: Colors.pink.shade900,
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                height: 30,
                width: 150,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: Colors.black,
                      ),
                      Text(
                        viewDate,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              leaveContainer(const Color(0xffCCFFCC), 'Presend', '0'),
              leaveContainer(const Color(0xffFFFFCC), 'Late', '0'),
              leaveContainer(const Color(0xffFFCCCC), 'Absent', '0'),
              leaveContainer(const Color(0xffFFFFCC), 'Half Day', '0'),
              leaveContainer(const Color(0xffFFCCFF), 'Paid Leave', '0')
            ],
          ),
        ),
        Expanded(
            child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return ListTile(
              title: const Text(
                'Wed, 16 Dec',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Casual'),
              trailing: trailingContainer(
                  backgroundColor[index], leave[index], textClr[index]),
            );
          },
        ))
      ]),
    );
  }

  Container trailingContainer(
      Color backgroundColor, String txt, Color textColor) {
    return Container(
      height: 25,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: backgroundColor,
      ),
      child: Center(
        child: Text(
          txt,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }

  Padding leaveContainer(Color color, String tittle, String count) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 70,
        width: 80,
        color: color,
        child: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(tittle),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    count,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
