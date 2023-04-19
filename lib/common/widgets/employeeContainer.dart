import 'package:flutter/material.dart';
import 'package:hr_and_crm/ui/branches/branches.dart';

class EmployeeContainer extends StatelessWidget {
   EmployeeContainer({Key? key, required this.name}) : super(key: key);

  String name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

      },
      child: Container(
        width: double.infinity,
        height: 160,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.shade200, //color of border
              width: 2, //width of border
            ),
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.brown,
                    ),
                    child: const Center(
                        child: Text(
                      "s",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white),
                    )),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                   Text(
                    name,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.location_on_outlined,
                    size: 20,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Icon(
                    Icons.phone_outlined,
                    size: 20,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Icon(
                    Icons.whatsapp,
                    size: 20,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 85,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                border: Border.all(
                                  color: Colors.grey.shade200,
                                  //color of border
                                  width: 2, //width of border
                                ),
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(child: const Text("Punch In")),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 85,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                border: Border.all(
                                  color: Colors.grey.shade200,
                                  //color of border
                                  width: 2, //width of border
                                ),
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(child: const Text("Punch In")),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 85,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                border: Border.all(
                                  color: Colors.grey.shade200,
                                  //color of border
                                  width: 2, //width of border
                                ),
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(child: const Text("Punch In")),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 85,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                border: Border.all(
                                  color: Colors.grey.shade200,
                                  //color of border
                                  width: 2, //width of border
                                ),
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(child: const Text("Punch In")),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: 85,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.green,
                            //color of border
                            width: 2, //width of border
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              "Full Day",
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.green,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
