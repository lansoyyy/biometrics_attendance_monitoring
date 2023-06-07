import 'package:cloud_firestore/cloud_firestore.dart';

Future addAttendance(String name, String nameOfEvent, String type, course,
    userId, section, year) async {
  final docUser = FirebaseFirestore.instance.collection('Attendance').doc();

  final json = {
    'name': name,
    'nameOfEvent': nameOfEvent,
    'date':
        '${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}',
    'type': type,
    'dateTime': DateTime.now(),
    'course': course,
    'id': userId,
    'section': section,
    'year': year
  };

  await docUser.set(json);
}
