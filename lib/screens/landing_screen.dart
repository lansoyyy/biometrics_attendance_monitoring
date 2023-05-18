import 'package:biometrics_attendance/screens/admin_home.dart';
import 'package:biometrics_attendance/screens/home_screen.dart';
import 'package:biometrics_attendance/utils/colors.dart';
import 'package:biometrics_attendance/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({Key? key}) : super(key: key);

  final box = GetStorage();

  late String id = '';
  late String password = '';

  late String newId = '';
  late String newPassword = '';
  late String confirmPassword = '';

  late String adminPassword = '';

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
        height: 380,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextBold(text: 'SIGN UP', fontSize: 18, color: Colors.white),
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
                      labelText: 'Enter your Password',
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
                  onPressed: () {
                    if (newPassword == confirmPassword) {
                      box.write('id', newId);
                      box.write('password', newPassword);
                      Fluttertoast.showToast(
                          msg:
                              'Account Created Succesfully! Login your Account');
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LandingScreen()));
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
            ],
          ),
        ),
      ),
    );
  }
}
