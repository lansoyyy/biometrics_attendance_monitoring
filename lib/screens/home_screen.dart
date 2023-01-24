import 'package:biometrics_attendance/screens/tabs/attendance_tab.dart';
import 'package:biometrics_attendance/screens/tabs/register_tab.dart';
import 'package:biometrics_attendance/utils/colors.dart';
import 'package:biometrics_attendance/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
                        'assets/images/logo.jpg',
                        height: 120,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextRegular(
                              text: 'University of Example',
                              fontSize: 14,
                              color: Colors.white),
                          TextRegular(
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
                    unselectedLabelColor: Colors.black,
                    indicator: BoxDecoration(color: Colors.black),
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: 'QRegular',
                      fontSize: 14,
                    ),
                    tabs: [
                      Tab(
                        text: 'Register',
                      ),
                      Tab(
                        text: 'Attendance',
                      ),
                      Tab(
                        text: 'List',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                child: TabBarView(children: [
                  const RegisterTab(),
                  const AttendanceTab(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: TextBold(
                            text: 'List of students',
                            fontSize: 18,
                            color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                        child: Container(
                          height: 380,
                          width: double.infinity,
                          color: Colors.white,
                          child: SingleChildScrollView(
                            child: DataTable(columns: [
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
                            ], rows: [
                              for (int i = 0; i < 50; i++)
                                DataRow(cells: [
                                  DataCell(
                                    TextRegular(
                                        text: 'John Doe',
                                        fontSize: 12,
                                        color: Colors.black),
                                  ),
                                  DataCell(
                                    TextRegular(
                                        text: 'Sports Day',
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
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
