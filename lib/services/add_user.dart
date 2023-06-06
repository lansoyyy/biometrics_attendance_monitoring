import 'package:cloud_firestore/cloud_firestore.dart';

Future addUser(studentId, name, course, form, password, year, section) async {
  final docUser = FirebaseFirestore.instance.collection('Users').doc(studentId);

  final json = {
    'name': name,
    'studentId': studentId,
    'password': password,
    'course': course,
    'dateTime': DateTime.now(),
    'id': docUser.id,
    'form': form,
    'status': 'Pending',
    'year': year,
    'section': section
  };

  await docUser.set(json);
}
