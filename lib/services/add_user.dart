import 'package:cloud_firestore/cloud_firestore.dart';

Future addUser(studentId, name, course, form) async {
  final docUser = FirebaseFirestore.instance.collection('Users').doc(studentId);

  final json = {
    'name': name,
    'studentId': studentId,
    'course': course,
    'dateTime': DateTime.now(),
    'id': docUser.id,
    'form': form,
    'status': 'Pending'
  };

  await docUser.set(json);
}
