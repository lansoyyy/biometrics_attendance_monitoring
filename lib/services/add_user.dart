import 'package:cloud_firestore/cloud_firestore.dart';

Future addUser(studentId, name, course, userId) async {
  final docUser = FirebaseFirestore.instance.collection('Users').doc(userId);

  final json = {
    'name': name,
    'studentId': studentId,
    'course': course,
    'dateTime': DateTime.now(),
    'id': docUser.id,
  };

  await docUser.set(json);
}
