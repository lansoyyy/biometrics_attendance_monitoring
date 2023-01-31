import 'package:biometrics_attendance/utils/colors.dart';
import 'package:biometrics_attendance/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        backgroundColor: secondary,
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              color: primary,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: 120,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 150,
                            child: TextRegular(
                                text: 'Carlos Hilado Memorial State University',
                                fontSize: 14,
                                color: Colors.white),
                          ),
                          TextBold(
                              text: 'Attendance checker',
                              fontSize: 24,
                              color: Colors.white)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 20),
              child: ClipRRect(
                child: Container(
                  height: 30,
                  color: Colors.white,
                  child: const TabBar(
                    unselectedLabelColor: Colors.white,
                    indicator: BoxDecoration(color: Colors.white),
                    labelColor: Colors.black,
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: 'QRegular',
                      fontSize: 14,
                    ),
                    tabs: [
                      // Tab(
                      //   text: 'Register',
                      // ),
                      // Tab(
                      //   text: 'Attendance',
                      // ),
                      Tab(
                        text: 'Attendance History',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                child: TabBarView(children: [
                  // const RegisterTab(),
                  // AttendanceTab(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: TextBold(
                            text: "Student's Attendance History",
                            fontSize: 18,
                            color: Colors.white),
                      ),
                      StreamBuilder<Object>(
                          stream: null,
                          builder: (context, snapshot) {
                            return Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 20),
                              child: Container(
                                height: 400,
                                width: double.infinity,
                                color: Colors.white,
                                child: SingleChildScrollView(
                                  child: DataTable(
                                      border: TableBorder.all(
                                        color: Colors.grey,
                                      ),
                                      columns: [
                                        DataColumn(
                                            label: TextBold(
                                                text: 'Name',
                                                fontSize: 14,
                                                color: Colors.black)),
                                        DataColumn(
                                            label: TextBold(
                                                text: 'Event',
                                                fontSize: 14,
                                                color: Colors.black)),
                                        DataColumn(
                                            label: TextBold(
                                                text: 'Date',
                                                fontSize: 14,
                                                color: Colors.black)),
                                      ],
                                      rows: [
                                        for (int i = 0; i < 50; i++)
                                          DataRow(
                                              color: MaterialStateProperty
                                                  .resolveWith<Color?>(
                                                      (Set<MaterialState>
                                                          states) {
                                                if (i.floor().isEven) {
                                                  return Colors.blueGrey[100];
                                                }
                                                return null; // Use the default value.
                                              }),
                                              cells: [
                                                DataCell(
                                                  TextRegular(
                                                      text: 'John Doe',
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                                DataCell(
                                                  TextRegular(
                                                      text:
                                                          'Sports Day - Time In',
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                                DataCell(
                                                  TextRegular(
                                                      text: '01/20/23',
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                )
                                              ]),
                                      ]),
                                ),
                              ),
                            );
                          }),
                    ],
                  )
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
