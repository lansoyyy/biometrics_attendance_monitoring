import 'package:biometrics_attendance/utils/colors.dart';
import 'package:biometrics_attendance/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotifTab extends StatefulWidget {
  const NotifTab({super.key});

  @override
  State<NotifTab> createState() => _NotifTabState();
}

class _NotifTabState extends State<NotifTab> {
  final DateTime _selectedDate = DateTime.now();
  String name = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: TextRegular(
            text: 'Notifications', fontSize: 18, color: Colors.white),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Event').snapshots(),
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
            return ListView.builder(
                itemCount: data.docs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Card(
                      elevation: 3,
                      child: ListTile(
                        trailing: Icon(
                          Icons.event,
                          color: primary,
                        ),
                        title: TextBold(
                            text: 'New Event: ${data.docs[index]['name']}',
                            fontSize: 16,
                            color: primary),
                        subtitle: TextRegular(
                            text:
                                '${data.docs[index]['day']}/${data.docs[index]['month']}/${data.docs[index]['year']}',
                            fontSize: 12,
                            color: primary),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
