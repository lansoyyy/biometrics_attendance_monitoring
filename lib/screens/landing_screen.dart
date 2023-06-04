import 'package:biometrics_attendance/screens/admin_home.dart';
import 'package:biometrics_attendance/screens/home_screen.dart';
import 'package:biometrics_attendance/utils/colors.dart';
import 'package:biometrics_attendance/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

import '../services/add_user.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({Key? key}) : super(key: key);

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
    return Scaffold(
      body: Container(
        color: primary,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 150,
              ),
              const SizedBox(
                height: 10,
              ),
              TextBold(
                  text: 'Attendance Monitoring',
                  fontSize: 18,
                  color: Colors.white),
              const SizedBox(
                height: 10,
              ),
              TextRegular(
                  text: 'Carlos Hilado Memorial State University',
                  fontSize: 12,
                  color: Colors.white),
              const SizedBox(
                height: 75,
              ),
              MaterialButton(
                height: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minWidth: 250,
                color: Colors.white,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return loginDialog(context);
                      }));
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => const SignupPage()));
                },
                child: TextBold(text: 'LOGIN', fontSize: 18, color: primary),
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                height: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minWidth: 250,
                color: Colors.white,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return signupDialog(context);
                      }));
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => const SignupPage()));
                },
                child: TextBold(text: 'REGISTER', fontSize: 18, color: primary),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white),
                ),
                child: MaterialButton(
                    height: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minWidth: 250,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: ((context) {
                            return Dialog(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: secondary,
                                    borderRadius: BorderRadius.circular(5)),
                                height: 250,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextBold(
                                          text: 'Continue as Admin',
                                          fontSize: 18,
                                          color: Colors.white),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: TextFormField(
                                          obscureText: true,
                                          onChanged: ((value) {
                                            adminPassword = value;
                                          }),
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                              ),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                              ),
                                              labelText: 'Enter Admin Passcode',
                                              labelStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'QRegular')),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      Center(
                                        child: MaterialButton(
                                          height: 50,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          minWidth: 250,
                                          color: Colors.white,
                                          onPressed: () {
                                            if (adminPassword == 'admin123') {
                                              box.write('user', 'admin');
                                              Fluttertoast.showToast(
                                                  msg: 'Logged in as Admin!');
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const AdminHomeScreen()));
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      'Invalid Admin Password! Try again');
                                            }
                                            // Navigator.of(context).push(MaterialPageRoute(
                                            //     builder: (context) => const SignupPage()));
                                          },
                                          child: TextBold(
                                              text: 'CONTINUE',
                                              fontSize: 18,
                                              color: secondary),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }));
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => const LoginPage()));
                    },
                    child: TextBold(
                        text: 'CONTINUE AS ADMIN',
                        fontSize: 12,
                        color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginDialog(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
            color: secondary, borderRadius: BorderRadius.circular(5)),
        height: 320,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextBold(text: 'LOGIN', fontSize: 18, color: Colors.white),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  onChanged: ((value) {
                    id = value;
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
                      labelText: 'Enter your STUDENT ID',
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
                    password = value;
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
                      labelText: 'Enter your Password',
                      labelStyle: TextStyle(
                          color: Colors.white, fontFamily: 'QRegular')),
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
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: '$id@gmail.com', password: password);

                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                    } catch (e) {
                      Fluttertoast.showToast(msg: e.toString());
                    }

                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => const SignupPage()));
                  },
                  child:
                      TextBold(text: 'LOGIN', fontSize: 18, color: secondary),
                ),
              ),
            ],
          ),
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
                        try {
                          final user = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: '$newId@gmail.com',
                                  password: name + newId);

                          addUser(newId, name, selectedItem, user.user!.uid);

                          Navigator.of(context).pop();

                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text(
                                      "Student's Password",
                                      style: TextStyle(
                                          fontFamily: 'QBold',
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Text(
                                      'Password is: ${name + newId} (Student name + Student Id)',
                                      style: const TextStyle(
                                          fontFamily: 'QRegular'),
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
                                    ],
                                  ));
                        } catch (e) {
                          Fluttertoast.showToast(msg: e.toString());
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
