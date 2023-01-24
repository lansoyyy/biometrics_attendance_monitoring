import 'package:biometrics_attendance/utils/colors.dart';
import 'package:biometrics_attendance/widgets/button_widget.dart';
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
                  const Center(child: Text('1')),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextBold(
                              text: 'Attendance',
                              fontSize: 18,
                              color: Colors.white),
                          const SizedBox(
                            height: 10,
                          ),
                          TextRegular(
                              text: 'Name:', fontSize: 14, color: Colors.white),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: SizedBox(
                              height: 40,
                              child: TextFormField(
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Quicksand'),
                                onChanged: (value) {},
                                decoration: const InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black),
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
                                    color: Colors.black,
                                    fontFamily: 'Quicksand'),
                                onChanged: (value) {},
                                decoration: const InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black),
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
                                        text: 'Month',
                                        fontSize: 14,
                                        color: Colors.white),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      child: SizedBox(
                                        height: 40,
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Quicksand'),
                                          onChanged: (value) {},
                                          decoration: const InputDecoration(
                                            fillColor: Colors.white,
                                            filled: true,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.white),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.black),
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
                                        text: 'Day',
                                        fontSize: 14,
                                        color: Colors.white),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      child: SizedBox(
                                        height: 40,
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Quicksand'),
                                          onChanged: (value) {},
                                          decoration: const InputDecoration(
                                            fillColor: Colors.white,
                                            filled: true,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.white),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.black),
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
                                        text: 'Year',
                                        fontSize: 14,
                                        color: Colors.white),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      child: SizedBox(
                                        height: 40,
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Quicksand'),
                                          onChanged: (value) {},
                                          decoration: const InputDecoration(
                                            fillColor: Colors.white,
                                            filled: true,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.white),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ),
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
                                  Image.asset(
                                    'assets/images/fingerprint.png',
                                    height: 70,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ButtonWidget(
                                      onPressed: () {}, text: 'Confirm')
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                  const Center(child: Text('3')),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
