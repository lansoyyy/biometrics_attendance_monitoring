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

  bool _value = false;

  List<String> dropdownItems = [
    'BSIT',
    'BSIS',
    'BS IND TECH (ARCHITECTURAL DRAFTING)',
    'BS IND TECH (AUTOMOTIVE)',
    'BS IND TECH (COMPUTER TECHNOLOGY)',
    'BS IND TECH (ELECTRICAL TECHNOLOGY)',
    'BS IND TECH (ELECTRONICS TECHNOLOGY)',
    'BS IND TECH (FOOD TRADES TECHNOLOGY)',
    'BS IND TECH (MECHANICAL TECHNOLOGY)',
    'BTVTED (ELECTRICAL TECHNOLOGY)',
    'BTVTED (ELECTRONICS TECHNOLOGY)',
    'BSCPE',
    'BSECE',
  ];

  String selectedItem = 'BSIT';
  @override
  Widget build(BuildContext context) {
    print(_value);
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
                          const SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, bottom: 10),
                              child: TextRegular(
                                  text: 'Course:',
                                  fontSize: 14,
                                  color: primary),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: primary,
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                              child: DropdownButton<String>(
                                underline: const SizedBox(),
                                value: selectedItem,
                                items: dropdownItems.map((String item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Center(
                                      child: SizedBox(
                                        width: 225,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'QRegular',
                                                fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedItem = newValue.toString();
                                  });
                                },
                              ),
                            ),
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
                        addEvent(name, _selectedDate, selectedItem);
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
        actions: [
          SizedBox(
            height: 30,
            width: 100,
            child: SwitchListTile(
              value: _value,
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
            ),
          ),
          const SizedBox(),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _value
              ? FirebaseFirestore.instance.collection('Event').snapshots()
              : FirebaseFirestore.instance
                  .collection('Event')
                  .where('status', isNotEqualTo: 'Archive')
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
                        trailing: data.docs[index]['status'] != 'Archive'
                            ? IconButton(
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection('Event')
                                      .doc(data.docs[index].id)
                                      .update({'status': 'Archive'});
                                },
                                icon: const Icon(
                                  Icons.archive_outlined,
                                  color: Colors.grey,
                                ),
                              )
                            : IconButton(
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection('Event')
                                      .doc(data.docs[index].id)
                                      .update({'status': 'Normal'});
                                },
                                icon: const Icon(
                                  Icons.visibility,
                                  color: Colors.grey,
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
