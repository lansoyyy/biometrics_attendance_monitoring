import 'package:biometrics_attendance/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../widgets/button_widget.dart';

class AttendanceTab extends StatefulWidget {
  @override
  State<AttendanceTab> createState() => _AttendanceTabState();
}

class _AttendanceTabState extends State<AttendanceTab> {
  var months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  var years = [
    '2023',
    '2024',
    '2025',
    '2026',
    '2027',
  ];

  var _value = 0;
  var _value1 = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextBold(text: 'Attendance', fontSize: 18, color: Colors.white),
            const SizedBox(
              height: 10,
            ),
            TextRegular(text: 'Name:', fontSize: 14, color: Colors.white),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: SizedBox(
                height: 40,
                child: TextFormField(
                  style: const TextStyle(
                      color: Colors.black, fontFamily: 'Quicksand'),
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextRegular(
                text: 'Name of event if any:',
                fontSize: 14,
                color: Colors.white),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: SizedBox(
                height: 40,
                child: TextFormField(
                  style: const TextStyle(
                      color: Colors.black, fontFamily: 'Quicksand'),
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 100,
                  child: Column(
                    children: [
                      TextRegular(
                          text: 'Month', fontSize: 14, color: Colors.white),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: 40,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 3, right: 3),
                              child: DropdownButton(
                                  underline:
                                      Container(color: Colors.transparent),
                                  isExpanded: true,
                                  value: _value,
                                  items: [
                                    for (int i = 0; i < months.length; i++)
                                      DropdownMenuItem(
                                          onTap: () {},
                                          value: i,
                                          child: TextRegular(
                                              text: months[i],
                                              fontSize: 12,
                                              color: Colors.black))
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _value = int.parse(value.toString());
                                    });
                                  }),
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Column(
                    children: [
                      TextRegular(
                          text: 'Day', fontSize: 14, color: Colors.white),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                color: Colors.black, fontFamily: 'Quicksand'),
                            onChanged: (value) {},
                            decoration: const InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Column(
                    children: [
                      TextRegular(
                          text: 'Year', fontSize: 14, color: Colors.white),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: 40,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 3, right: 3),
                              child: DropdownButton(
                                  underline:
                                      Container(color: Colors.transparent),
                                  isExpanded: true,
                                  value: _value1,
                                  items: [
                                    for (int i = 0; i < years.length; i++)
                                      DropdownMenuItem(
                                          onTap: () {},
                                          value: i,
                                          child: TextRegular(
                                              text: years[i],
                                              fontSize: 12,
                                              color: Colors.black))
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _value1 = int.parse(value.toString());
                                    });
                                  }),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
                color: Colors.white,
                width: double.infinity,
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onLongPress: () {
                        Fluttertoast.showToast(
                            msg: 'Fingerprint scanned succesfully!');
                      },
                      child: Image.asset(
                        'assets/images/fingerprint.png',
                        height: 70,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ButtonWidget(onPressed: () {}, text: 'Confirm')
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
