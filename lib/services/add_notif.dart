import 'package:cloud_firestore/cloud_firestore.dart';

Future addNotif(evnetName, DateTime date) async {
  final docUser = FirebaseFirestore.instance.collection('Notif').doc();

  final json = {
    'name': evnetName,
    'day': date.day,
    'month': date.month,
    'year': date.year,
    'dateTime': DateTime.now(),
    'id': docUser.id,
  };

  await docUser.set(json);
}
