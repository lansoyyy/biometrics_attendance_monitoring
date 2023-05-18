import 'package:biometrics_attendance/utils/colors.dart';
import 'package:biometrics_attendance/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class EventTab extends StatelessWidget {
  const EventTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: primary,
        title: TextRegular(text: 'Events', fontSize: 18, color: Colors.white),
        centerTitle: true,
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return null;
      }),
    );
  }
}
