import 'package:biometrics_attendance/screens/accounts_page.dart';
import 'package:biometrics_attendance/screens/landing_screen.dart';
import 'package:biometrics_attendance/screens/tabs/event_tab.dart';
import 'package:biometrics_attendance/utils/colors.dart';
import 'package:biometrics_attendance/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:intl/intl.dart' show DateFormat, toBeginningOfSentenceCase;

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final box = GetStorage();

  late String id = '';
  late String password = '';

  late String newId = '';

  late String adminPassword = '';
  String name = '';

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
  String selectedCourse = 'BSIT';

  final doc = pw.Document();

  List names = [];
  List types = [];
  List ids = [];
  List courses = [];
  List sections = [];

  List datesAndTime = [];

  String cdate2 = DateFormat("MMMM, dd, yyyy").format(DateTime.now());
  final searchController = TextEditingController();

  List<String> dropdownYears = [
    '1st Year',
    '2nd Year',
    '3rd Year',
    '4th Year',
  ];
  String selectedYear = '1st Year';
  String nameOfEvent = '';

  int dropValue = 0;
  String nameSearched = '';

  void _createPdf() async {
    /// for using an image from assets
    // final image = await imageFromAssetBundle('assets/image.png');

    final image = await imageFromAssetBundle('assets/images/logo.jpg');

    doc.addPage(
      pw.Page(
        build: ((context) {
          return pw.Column(children: [
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Center(
                    child: pw.Image(image, height: 80, width: 80),
                  ),
                  pw.Column(children: [
                    pw.SizedBox(height: 20),
                    pw.Text('Carlos Hilado Memorial State University',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(height: 5),
                    pw.Text('Bacolod, 6100 Negros Occidental',
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.normal, fontSize: 10)),
                  ]),
                  pw.SizedBox(width: 20),
                ]),
            pw.SizedBox(height: 20),
            pw.Text(cdate2),
            pw.SizedBox(height: 10),
            pw.Text('Attendance List - $selectedCourse'),
            pw.SizedBox(height: 20),
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                  children: [
                    pw.Text('Student ID No.'),
                    pw.Text('Student Name'),
                    pw.Text('Course'),
                    pw.Text('Section'),
                    pw.Text('Attendance Type'),
                    pw.Text('Date and Time'),
                  ],
                ),
                for (int i = 0; i < ids.length; i++)
                  pw.TableRow(
                    children: [
                      pw.Text(ids[i]),
                      pw.Text(names[i]),
                      pw.Text(courses[i]),
                      pw.Text(sections[i]),
                      pw.Text(types[i]),
                      pw.Text(datesAndTime[i]),
                    ],
                  ),
              ],
            ),
          ]);
        }),
        pageFormat: PdfPageFormat.a4,
      ),
    ); // Page

    /// print the document using the iOS or Android print service:
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());

    /// share the document to other applications:

    /// tutorial for using path_provider: https://www.youtube.com/watch?v=fJtFDrjEvE8
    /// save PDF with Flutter library "path_provider":
  }

  final scroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        backgroundColor: secondary,
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              color: primary,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10, top: 20),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const AccountsPage()));
                            },
                            icon: const Icon(
                              Icons.account_circle_sharp,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const EventTab()));
                            },
                            icon: const Icon(
                              Icons.event,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: const Text(
                                            'Logout Confirmation',
                                            style: TextStyle(
                                                fontFamily: 'QBold',
                                                fontWeight: FontWeight.bold),
                                          ),
                                          content: const Text(
                                            'Are you sure you want to Logout?',
                                            style: TextStyle(
                                                fontFamily: 'QRegular'),
                                          ),
                                          actions: <Widget>[
                                            MaterialButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                              child: const Text(
                                                'Close',
                                                style: TextStyle(
                                                    fontFamily: 'QRegular',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            MaterialButton(
                                              onPressed: () {
                                                Fluttertoast.showToast(
                                                    msg: 'Admin logged out!');
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const LandingScreen()));
                                              },
                                              child: const Text(
                                                'Continue',
                                                style: TextStyle(
                                                    fontFamily: 'QRegular',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ));
                              },
                              icon: const Icon(Icons.logout,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          height: 120,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 150,
                              child: TextRegular(
                                  text:
                                      'Carlos Hilado Memorial State University',
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                            TextBold(
                                text: 'Attendance checker',
                                fontSize: 24,
                                color: Colors.white)
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 20),
              child: ClipRRect(
                child: Container(
                  height: 30,
                  color: Colors.white,
                  child: const TabBar(
                    unselectedLabelColor: Colors.white,
                    indicator: BoxDecoration(color: Colors.white),
                    labelColor: Colors.black,
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: 'QRegular',
                      fontSize: 14,
                    ),
                    tabs: [
                      // Tab(
                      //   text: 'Register',
                      // ),
                      // Tab(
                      //   text: 'Attendance',
                      // ),
                      Tab(
                        text: 'Attendance History',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                child: TabBarView(children: [
                  // const RegisterTab(),
                  // AttendanceTab(),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextBold(
                                  text: "Student's Attendance History",
                                  fontSize: 18,
                                  color: Colors.white),
                              IconButton(
                                onPressed: () {
                                  if (names.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: 'Attendance List is Empty');
                                  } else {
                                    _createPdf();
                                  }
                                },
                                icon: const Icon(
                                  Icons.print,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Center(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    nameSearched = value;
                                  });
                                },
                                decoration: const InputDecoration(
                                    hintText: 'Search',
                                    hintStyle: TextStyle(
                                        fontFamily: 'QRegular',
                                        color: Colors.white),
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    )),
                                controller: searchController,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 210,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.white,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: DropdownButton<String>(
                                          underline: const SizedBox(),
                                          value: selectedCourse,
                                          items:
                                              dropdownItems.map((String item) {
                                            return DropdownMenuItem<String>(
                                              value: item,
                                              child: Center(
                                                child: SizedBox(
                                                  width: 144,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    child: Text(
                                                      item,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontFamily:
                                                              'QRegular',
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            setState(() {
                                              selectedCourse =
                                                  newValue.toString();
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 182,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.white,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: DropdownButton<String>(
                                        underline: const SizedBox(),
                                        value: selectedYear,
                                        items: dropdownYears.map((String item) {
                                          return DropdownMenuItem<String>(
                                            value: item,
                                            child: Center(
                                              child: SizedBox(
                                                width: 120,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    item,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'QRegular',
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedYear = newValue.toString();
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextRegular(
                              text: 'Event:',
                              fontSize: 14,
                              color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Event')
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  print('error');
                                  return const Center(child: Text('Error'));
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
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

                                return Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white,
                                      ),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, right: 30),
                                    child: DropdownButton(
                                      iconEnabledColor: Colors.white,
                                      iconDisabledColor: Colors.white,
                                      dropdownColor: primary,
                                      underline: const SizedBox(),
                                      value: dropValue,
                                      items: [
                                        for (int i = 0;
                                            i < data.docs.length;
                                            i++)
                                          DropdownMenuItem(
                                            onTap: () {
                                              nameOfEvent =
                                                  data.docs[i]['name'];
                                            },
                                            value: i,
                                            child: Center(
                                              child: SizedBox(
                                                width: 225,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    data.docs[i]['name'],
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'QBold',
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                      ],
                                      onChanged: (newValue) {
                                        setState(() {
                                          dropValue =
                                              int.parse(newValue.toString());
                                        });
                                      },
                                    ),
                                  ),
                                );
                              }),
                        ),
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Attendance')
                                .where('course', isEqualTo: selectedCourse)
                                .where('year', isEqualTo: selectedYear)
                                .where('nameOfEvent', isEqualTo: nameOfEvent)
                                .where('name',
                                    isGreaterThanOrEqualTo:
                                        toBeginningOfSentenceCase(nameSearched))
                                .where('name',
                                    isLessThan:
                                        '${toBeginningOfSentenceCase(nameSearched)}z')
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                print('error');
                                return const Center(child: Text('Error'));
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
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
                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 20),
                                child: Container(
                                  height: 400,
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
                                                      text: 'Student ID No.',
                                                      fontSize: 14,
                                                      color: Colors.black)),
                                              DataColumn(
                                                  label: TextBold(
                                                      text: 'Name',
                                                      fontSize: 14,
                                                      color: Colors.black)),
                                              DataColumn(
                                                  label: TextBold(
                                                      text: 'Course',
                                                      fontSize: 14,
                                                      color: Colors.black)),
                                              DataColumn(
                                                  label: TextBold(
                                                      text: 'Section',
                                                      fontSize: 14,
                                                      color: Colors.black)),
                                              DataColumn(
                                                  label: TextBold(
                                                      text: 'Attendance Type',
                                                      fontSize: 14,
                                                      color: Colors.black)),
                                              DataColumn(
                                                  label: TextBold(
                                                      text: 'Date',
                                                      fontSize: 14,
                                                      color: Colors.black)),
                                            ],
                                            rows: [
                                              for (int i = 0;
                                                  i < data.docs.length;
                                                  i++)
                                                DataRow(
                                                    color: MaterialStateProperty
                                                        .resolveWith<Color?>(
                                                            (Set<MaterialState>
                                                                states) {
                                                      if (i.floor().isEven) {
                                                        return Colors
                                                            .blueGrey[100];
                                                      }
                                                      return null; // Use the default value.
                                                    }),
                                                    cells: [
                                                      DataCell(
                                                        TextRegular(
                                                            text:
                                                                '${data.docs[i]['id']}',
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      DataCell(
                                                        Builder(
                                                            builder: (context) {
                                                          ids.clear();
                                                          names.clear();
                                                          types.clear();
                                                          datesAndTime.clear();
                                                          courses.clear();
                                                          sections.clear();
                                                          ids.add(data.docs[i]
                                                              ['id']);
                                                          names.add(data.docs[i]
                                                              ['name']);
                                                          types.add(data.docs[i]
                                                              ['type']);
                                                          courses.add(
                                                              data.docs[i]
                                                                  ['course']);
                                                          sections.add(
                                                              data.docs[i]
                                                                  ['section']);
                                                          datesAndTime.add(
                                                            DateFormat.yMMMd()
                                                                .add_jm()
                                                                .format(data
                                                                    .docs[i][
                                                                        'dateTime']
                                                                    .toDate()),
                                                          );
                                                          return TextRegular(
                                                              text: data.docs[i]
                                                                  ['name'],
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.black);
                                                        }),
                                                      ),
                                                      DataCell(
                                                        TextRegular(
                                                            text:
                                                                '${data.docs[i]['course']}',
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      DataCell(
                                                        TextRegular(
                                                            text:
                                                                '${data.docs[i]['section']}',
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      DataCell(
                                                        TextRegular(
                                                            text:
                                                                '${data.docs[i]['type']}',
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      DataCell(
                                                        TextRegular(
                                                            text: data.docs[i]
                                                                ['date'],
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black),
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
                    ),
                  )
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
