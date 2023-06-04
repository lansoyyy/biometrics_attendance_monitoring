import 'package:biometrics_attendance/services/add_notif.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future addEvent(name, DateTime date, course) async {
  final docUser = FirebaseFirestore.instance.collection('Event').doc();

  final json = {
    'name': name,
    'day': date.day,
    'month': date.month,
    'year': date.year,
    'dateTime': DateTime.now(),
    'id': docUser.id,
    'status': 'Normal',
    'course': course
  };

  addNotif(name, date);

  await docUser.set(json);
}
