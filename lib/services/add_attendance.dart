import 'package:cloud_firestore/cloud_firestore.dart';

Future addAttendance(String name, String date, String nameOfEvent, String type,
    course, userId) async {
  final docUser = FirebaseFirestore.instance.collection('Attendance').doc();

  final json = {
    'name': name,
    'nameOfEvent': nameOfEvent,
    'date': date,
    'type': type,
    'dateTime': DateTime.now(),
    'course': course,
    'id': userId,
  };

  await docUser.set(json);
}
