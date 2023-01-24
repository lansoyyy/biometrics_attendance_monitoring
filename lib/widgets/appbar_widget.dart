import 'package:biometrics_attendance/widgets/text_widget.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget AppbarWidget(String title, BuildContext context) {
  return AppBar(
    elevation: 3,
    foregroundColor: Colors.grey,
    backgroundColor: Colors.white,
    title: TextRegular(text: title, fontSize: 16, color: Colors.grey),
    centerTitle: true,
  );
}
