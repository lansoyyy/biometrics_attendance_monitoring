import 'package:biometrics_attendance/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../widgets/button_widget.dart';

class RegisterTab extends StatelessWidget {
  const RegisterTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextBold(text: 'Registration', fontSize: 18, color: Colors.white),
            const SizedBox(
              height: 10,
            ),
            TextRegular(text: 'First name:', fontSize: 14, color: Colors.white),
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
            TextRegular(text: 'Last name:', fontSize: 14, color: Colors.white),
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
                text: 'Student ID Number', fontSize: 14, color: Colors.white),
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
              height: 20,
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
