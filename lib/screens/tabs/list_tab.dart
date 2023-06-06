import 'package:biometrics_attendance/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ListTab extends StatelessWidget {
  final box = GetStorage();

  ListTab({super.key});

  final scroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    print(box.read('password'));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: TextBold(
              text: 'Your Attendance History',
              fontSize: 18,
              color: Colors.white),
        ),
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Attendance')
                .where('id', isEqualTo: box.read('id'))
                .orderBy('dateTime', descending: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                print('error');
                return const Center(child: Text('Error'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                print('waiting');
                return const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Colors.black,
                  )),
                );
              }

              final data = snapshot.requireData;
              print(data.docs.length);
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                child: Container(
                  height: 380,
                  width: double.infinity,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Scrollbar(
                      controller: scroll,
                      child: SingleChildScrollView(
                        controller: scroll,
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                            border: TableBorder.all(
                              color: Colors.grey,
                            ),
                            columns: [
                              DataColumn(
                                  label: TextBold(
                                      text: 'Student\nID NO.',
                                      fontSize: 14,
                                      color: Colors.black)),
                              DataColumn(
                                  label: TextBold(
                                      text: 'Name',
                                      fontSize: 14,
                                      color: Colors.black)),
                              DataColumn(
                                  label: TextBold(
                                      text: 'Attendace\nType',
                                      fontSize: 14,
                                      color: Colors.black)),
                              DataColumn(
                                  label: TextBold(
                                      text: 'Date',
                                      fontSize: 14,
                                      color: Colors.black)),
                            ],
                            rows: [
                              for (int i = 0; i < data.docs.length; i++)
                                DataRow(
                                    color: MaterialStateProperty.resolveWith<
                                        Color?>((Set<MaterialState> states) {
                                      if (i.floor().isEven) {
                                        return Colors.blueGrey[50];
                                      }
                                      return null; // Use the default value.
                                    }),
                                    cells: [
                                      DataCell(
                                        TextRegular(
                                            text: data.docs[i]['id'],
                                            fontSize: 12,
                                            color: Colors.black),
                                      ),
                                      DataCell(
                                        TextRegular(
                                            text: data.docs[i]['name'],
                                            fontSize: 12,
                                            color: Colors.black),
                                      ),
                                      DataCell(
                                        TextRegular(
                                            text: '${data.docs[i]['type']}',
                                            fontSize: 12,
                                            color: Colors.black),
                                      ),
                                      DataCell(
                                        TextRegular(
                                            text: data.docs[i]['date'],
                                            fontSize: 12,
                                            color: Colors.black),
                                      )
                                    ]),
                            ]),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ],
    );
  }
}
