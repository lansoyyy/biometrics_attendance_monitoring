import 'package:biometrics_attendance/screens/home_screen.dart';
import 'package:biometrics_attendance/services/add_attendance.dart';
import 'package:biometrics_attendance/utils/colors.dart';
import 'package:biometrics_attendance/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';
import '../../widgets/button_widget.dart';

class AttendanceTab extends StatefulWidget {
  const AttendanceTab({super.key});

  @override
  State<AttendanceTab> createState() => _AttendanceTabState();
}

class _AttendanceTabState extends State<AttendanceTab> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyCourse();
  }

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

  bool _timeIn = false;
  bool _timeOut = false;

  final _value = 0;
  final _value1 = 0;

  String month = '01';
  String day = '';
  String year = '2023';

  String nameOfEvent = '';

  final LocalAuthentication auth = LocalAuthentication();

  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  bool authenticated = false;

  String course = '';
  String userId = '';
  String myname = '';

  final box = GetStorage();

  getMyCourse() {
    FirebaseFirestore.instance
        .collection('Users')
        .where(
          'id',
          isEqualTo: box.read('id'),
        )
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        setState(() {
          course = doc['course'];
          userId = doc['studentId'];
          myname = doc['name'];
        });
      }
    });
  }

  Future<void> _authenticateWithBiometrics() async {
    // only Biometrics

    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });

    if (authenticated) {
      Fluttertoast.showToast(msg: 'Fingerprint scanned succesfully!');
    } else {
      Fluttertoast.showToast(msg: 'Fingerprint scanned unsuccesfully!');
    }
    print(authenticated);
  }

  String selectedItem = '';
  int dropValue = 0;

  @override
  Widget build(BuildContext context) {
    print('hey $course');
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextBold(
                text: 'Attendance Sheet', fontSize: 18, color: Colors.white),
            const SizedBox(
              height: 10,
            ),
            TextRegular(
                text: 'Name of event if any:',
                fontSize: 14,
                color: Colors.white),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Event')
                    .where('day', isEqualTo: DateTime.now().day)
                    .where('month', isEqualTo: DateTime.now().month)
                    .where('year', isEqualTo: DateTime.now().year)
                    .where('course', isEqualTo: course)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    print('error');
                    return const Center(child: Text('Error'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
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

                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: DropdownButton(
                        iconEnabledColor: Colors.white,
                        iconDisabledColor: Colors.white,
                        dropdownColor: primary,
                        underline: const SizedBox(),
                        value: dropValue,
                        items: [
                          for (int i = 0; i < data.docs.length; i++)
                            DropdownMenuItem(
                              onTap: () {
                                nameOfEvent = data.docs[i]['name'];
                              },
                              value: i,
                              child: Center(
                                child: SizedBox(
                                  width: 225,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      data.docs[i]['name'],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'QBold',
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                            )
                        ],
                        onChanged: (newValue) {
                          setState(() {
                            dropValue = int.parse(newValue.toString());
                          });
                        },
                      ),
                    ),
                  );
                }),
            const SizedBox(
              height: 10,
            ),
            CheckboxListTile(
              tileColor: Colors.white,
              title: TextRegular(
                  text: 'Time In', fontSize: 12, color: Colors.black),
              value: _timeIn,
              onChanged: (value) {
                setState(() {
                  _timeIn = value!;
                  if (value) _timeOut = false;
                });
              },
            ),
            CheckboxListTile(
              tileColor: Colors.white,
              title: TextRegular(
                  text: 'Time Out', fontSize: 12, color: Colors.black),
              value: _timeOut,
              onChanged: (value) {
                setState(() {
                  _timeOut = value!;
                  if (value) _timeIn = false;
                });
              },
            ),
            const SizedBox(
              height: 10,
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
                      onTap: () {
                        _authenticateWithBiometrics();
                      },
                      child: Image.asset(
                        'assets/images/fingerprint.png',
                        height: 70,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ButtonWidget(
                        onPressed: () {
                          print(nameOfEvent);
                          if (nameOfEvent == '') {
                            Fluttertoast.showToast(msg: 'No event selected');
                          } else {
                            if (authenticated) {
                              Fluttertoast.showToast(
                                  msg: 'Attendance Added Succesfully!');
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomeScreen()));
                              if (_timeIn == true) {
                                addAttendance(myname, nameOfEvent, 'Time In',
                                    course, box.read('id'));
                              } else {
                                addAttendance(myname, nameOfEvent, 'Time Out',
                                    course, box.read('id'));
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Cannot Proceed! Invalid Fingerprint');
                            }
                          }
                        },
                        text: 'Confirm')
                  ],
                )),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
