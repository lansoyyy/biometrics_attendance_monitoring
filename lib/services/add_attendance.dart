import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

Future addAttendance(
    String name, String date, String nameOfEvent, String type, course) async {
  final docUser = FirebaseFirestore.instance.collection('Attendance').doc();

  final box = GetStorage();

  final json = {
    'name': name,
    'nameOfEvent': nameOfEvent,
    'date': date,
    'type': type,
    'dateTime': DateTime.now(),
    'id': box.read('id'),
    'password': box.read('password'),
    'course': course
  };

  await docUser.set(json);
}
