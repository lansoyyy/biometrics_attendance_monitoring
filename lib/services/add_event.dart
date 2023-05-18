import 'package:cloud_firestore/cloud_firestore.dart';

Future addEvent(name, DateTime date) async {
  final docUser = FirebaseFirestore.instance.collection('Event').doc();

  final json = {
    'name': name,
    'day': date.day,
    'month': date.month,
    'year': date.year,
    'dateTime': DateTime.now(),
    'id': docUser.id,
  };

  await docUser.set(json);
}
