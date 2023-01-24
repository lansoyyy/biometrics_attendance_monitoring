import 'package:biometrics_attendance/screens/tabs/attendance_tab.dart';
import 'package:biometrics_attendance/screens/tabs/list_tab.dart';
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
            const Expanded(
              child: SizedBox(
                child: TabBarView(children: [
                  RegisterTab(),
                  AttendanceTab(),
                  ListTab(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
