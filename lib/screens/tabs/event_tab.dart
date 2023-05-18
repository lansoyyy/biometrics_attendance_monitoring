import 'package:biometrics_attendance/services/add_event.dart';
import 'package:biometrics_attendance/utils/colors.dart';
import 'package:biometrics_attendance/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class EventTab extends StatefulWidget {
  const EventTab({super.key});

  @override
  State<EventTab> createState() => _EventTabState();
}

class _EventTabState extends State<EventTab> {
  DateTime _selectedDate = DateTime.now();
  String name = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: TextRegular(
                      text: 'Adding event', fontSize: 14, color: Colors.black),
                  content: StatefulBuilder(builder: (context, setState) {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: TextFormField(
                              onChanged: ((value) {
                                name = value;
                              }),
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  labelText: 'Name of Event',
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'QRegular')),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              const Text('Event Date: '),
                              Expanded(
                                child: TextButton(
                                  child: Builder(builder: (context) {
                                    final DateFormat formatter =
                                        DateFormat('yyyy-MM-dd');
                                    final String formattedDate =
                                        formatter.format(_selectedDate);
                                    return Text(
                                      formattedDate.toString(),
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'QBold',
                                          color: primary),
                                    );
                                  }),
                                  onPressed: () async {
                                    final DateTime? picked =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: _selectedDate,
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2100),
                                    );
                                    if (picked != null &&
                                        picked != _selectedDate) {
                                      setState(() {
                                        _selectedDate = picked;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: TextRegular(
                          text: 'Close', fontSize: 12, color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        addEvent(name, _selectedDate);
                        Navigator.pop(context);
                        Fluttertoast.showToast(msg: 'Event Added!');
                      },
                      child: TextBold(
                          text: 'Continue', fontSize: 14, color: Colors.black),
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: primary,
        title: TextRegular(text: 'Events', fontSize: 18, color: Colors.white),
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
                        title: TextBold(
                            text: data.docs[index]['name'],
                            fontSize: 18,
                            color: primary),
                        subtitle: TextRegular(
                            text:
                                '${data.docs[index]['day']}/${data.docs[index]['month']}/${data.docs[index]['year']}',
                            fontSize: 12,
                            color: primary),
                        trailing: IconButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('Event')
                                .doc(data.docs[index].id)
                                .delete();
                          },
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
