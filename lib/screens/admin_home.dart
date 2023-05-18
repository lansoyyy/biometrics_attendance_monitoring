import 'package:biometrics_attendance/screens/landing_screen.dart';
import 'package:biometrics_attendance/screens/tabs/event_tab.dart';
import 'package:biometrics_attendance/services/add_user.dart';
import 'package:biometrics_attendance/utils/colors.dart';
import 'package:biometrics_attendance/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final box = GetStorage();

  late String id = '';
  late String password = '';

  late String newId = '';
  late String newPassword = '';
  late String confirmPassword = '';

  late String adminPassword = '';
  String name = '';

  List<String> dropdownItems = [
    'BSIT',
    'BSIS',
    'BS IND TECH (ARCHITECTURAL DRAFTING)',
    'BS IND TECH (AUTOMOTIVE)',
    'BS IND TECH (COMPUTER TECHNOLOGY)',
    'BS IND TECH (ELECTRICAL TECHNOLOGY)',
    'BS IND TECH (ELECTRONICS TECHNOLOGY)',
    'BS IND TECH (FOOD TRADES TECHNOLOGY)',
    'BS IND TECH (MECHANICAL TECHNOLOGY)',
    'BTVTED (ELECTRICAL TECHNOLOGY)',
    'BTVTED (ELECTRONICS TECHNOLOGY)',
    'BSCPE',
    'BSECE',
  ];

  String selectedItem = 'BSIT';

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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10, top: 20),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return signupDialog(context);
                                  }));
                            },
                            icon: const Icon(
                              Icons.account_circle_sharp,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const EventTab()));
                            },
                            icon: const Icon(
                              Icons.event,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
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
                                            style: TextStyle(
                                                fontFamily: 'QRegular'),
                                          ),
                                          actions: <Widget>[
                                            MaterialButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                              child: const Text(
                                                'Close',
                                                style: TextStyle(
                                                    fontFamily: 'QRegular',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            MaterialButton(
                                              onPressed: () {
                                                Fluttertoast.showToast(
                                                    msg: 'Admin logged out!');
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ));
                              },
                              icon: const Icon(Icons.logout,
                                  color: Colors.white)),
                        ],
                      ),
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
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Attendance')
                              .orderBy('dateTime', descending: true)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              print('error');
                              return const Center(child: Text('Error'));
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              print('waiting');
                              return const Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.black,
                                )),
                              );
                            }

                            final data = snapshot.requireData;
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
                                        for (int i = 0;
                                            i < data.docs.length;
                                            i++)
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
                                                      text: data.docs[i]
                                                          ['name'],
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                                DataCell(
                                                  TextRegular(
                                                      text:
                                                          '${data.docs[i]['nameOfEvent']} - ${data.docs[i]['type']}',
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                                DataCell(
                                                  TextRegular(
                                                      text: data.docs[i]
                                                          ['date'],
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

  Widget signupDialog(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
            color: secondary, borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: StatefulBuilder(builder: (context, setState) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextBold(text: 'SIGN UP', fontSize: 18, color: Colors.white),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
                      onChanged: ((value) {
                        name = value;
                      }),
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelText: 'Enter Student Name',
                          labelStyle: TextStyle(
                              color: Colors.white, fontFamily: 'QRegular')),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
                      onChanged: ((value) {
                        newId = value;
                      }),
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelText: 'Enter STUDENT ID',
                          labelStyle: TextStyle(
                              color: Colors.white, fontFamily: 'QRegular')),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
                      obscureText: true,
                      onChanged: ((value) {
                        newPassword = value;
                      }),
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelText: 'Enter Password',
                          labelStyle: TextStyle(
                              color: Colors.white, fontFamily: 'QRegular')),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
                      obscureText: true,
                      onChanged: ((value) {
                        confirmPassword = value;
                      }),
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(
                              color: Colors.white, fontFamily: 'QRegular')),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextRegular(
                        text: 'Course:', fontSize: 14, color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: DropdownButton<String>(
                        underline: const SizedBox(),
                        value: selectedItem,
                        items: dropdownItems.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Center(
                              child: SizedBox(
                                width: 225,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'QRegular',
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedItem = newValue.toString();
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: MaterialButton(
                      height: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minWidth: 250,
                      color: Colors.white,
                      onPressed: () async {
                        if (newPassword == confirmPassword) {
                          try {
                            final user = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: '$newId@gmail.com',
                                    password: newPassword);

                            addUser(newId, name, selectedItem, user.user!.uid);
                            Fluttertoast.showToast(
                                msg: 'Account Created Succesfully!');
                            Navigator.of(context).pop();
                          } catch (e) {
                            Fluttertoast.showToast(msg: e.toString());
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Password do not match! Try again');
                        }
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => const SignupPage()));
                      },
                      child: TextBold(
                          text: 'REGISTER', fontSize: 18, color: secondary),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
