import 'package:biometrics_attendance/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ListTab extends StatelessWidget {
  const ListTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        StreamBuilder<Object>(
            stream: null,
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                child: Container(
                  height: 380,
                  width: double.infinity,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: DataTable(
                        border: TableBorder.all(
                          color: Colors.grey,
                        ),
                        columns: [
                          DataColumn(
                              label: TextBold(
                                  text: 'Name',
                                  fontSize: 14,
                                  color: Colors.black)),
                          DataColumn(
                              label: TextBold(
                                  text: 'Event',
                                  fontSize: 14,
                                  color: Colors.black)),
                          DataColumn(
                              label: TextBold(
                                  text: 'Date',
                                  fontSize: 14,
                                  color: Colors.black)),
                        ],
                        rows: [
                          for (int i = 0; i < 50; i++)
                            DataRow(
                                color:
                                    MaterialStateProperty.resolveWith<Color?>(
                                        (Set<MaterialState> states) {
                                  if (i.floor().isEven) {
                                    return Colors.blueGrey[50];
                                  }
                                  return null; // Use the default value.
                                }),
                                cells: [
                                  DataCell(
                                    TextRegular(
                                        text: 'John Doe',
                                        fontSize: 12,
                                        color: Colors.black),
                                  ),
                                  DataCell(
                                    TextRegular(
                                        text: 'Sports Day - Time In',
                                        fontSize: 12,
                                        color: Colors.black),
                                  ),
                                  DataCell(
                                    TextRegular(
                                        text: '01/20/23',
                                        fontSize: 12,
                                        color: Colors.black),
                                  )
                                ]),
                        ]),
                  ),
                ),
              );
            }),
      ],
    );
  }
}
