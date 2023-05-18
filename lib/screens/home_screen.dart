import 'package:biometrics_attendance/screens/landing_screen.dart';
import 'package:biometrics_attendance/screens/tabs/attendance_tab.dart';
import 'package:biometrics_attendance/screens/tabs/list_tab.dart';
import 'package:biometrics_attendance/utils/colors.dart';
import 'package:biometrics_attendance/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: secondary,
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              color: primary,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10, top: 20),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text(
                                        'Logout Confirmation',
                                        style: TextStyle(
                                            fontFamily: 'QBold',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      content: const Text(
                                        'Are you sure you want to Logout?',
                                        style:
                                            TextStyle(fontFamily: 'QRegular'),
                                      ),
                                      actions: <Widget>[
                                        MaterialButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(true),
                                          child: const Text(
                                            'Close',
                                            style: TextStyle(
                                                fontFamily: 'QRegular',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        MaterialButton(
                                          onPressed: () {
                                            Fluttertoast.showToast(
                                                msg: 'User logged out!');
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LandingScreen()));
                                          },
                                          child: const Text(
                                            'Continue',
                                            style: TextStyle(
                                                fontFamily: 'QRegular',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ));
                          },
                          icon: const Icon(Icons.logout, color: Colors.white)),
                    ),
                  ),
                  Padding(
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
                                  text:
                                      'Carlos Hilado Memorial State University',
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
                ],
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
                      // Tab(
                      //   text: 'Register',
                      // ),
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
                  // const RegisterTab(),
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
