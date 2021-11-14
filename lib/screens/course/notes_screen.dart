import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pipshub/screens/course/notes_details.dart';

class NotesScreen extends StatefulWidget {
  final String courseId;

  const NotesScreen({Key? key, required this.courseId}) : super(key: key);

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent.withOpacity(1),
        title: Text("Notes"),
        centerTitle: true,
      ),
      body: Column(children: [
        Container(
            padding: EdgeInsets.only(top: 15, right: 10, left: 10),
            height: MediaQuery.of(context).size.height / 1.8,
            child: FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('course')
                    .doc(widget.courseId)
                    .collection("pdfs")
                    .orderBy("pdfName", descending: false)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // <3> Retrieve `List<DocumentSnapshot>` from snapshot
                    final List<DocumentSnapshot> documents =
                        snapshot.data!.docs;
                    return ListView(
                        children: documents
                            .map((doc) => GestureDetector(
                                  onTap: isLoading == true
                                      ? null
                                      : () async {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NotesDetails(
                                                        pdfUrl: doc['pdfUrl'],
                                                        pdfName: doc['pdfName'],
                                                      )));
                                          setState(() {
                                            isLoading = true;
                                          });
                                        },
                                  child: Card(
                                    child: ListTile(
                                      title: isLoading == true
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : Text(
                                              isLoading == true
                                                  ? "Opening...."
                                                  : doc['pdfName'],
                                              style: isLoading == true
                                                  ? TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      backgroundColor: Colors
                                                          .tealAccent.shade100,
                                                      color: Colors.black,
                                                      fontSize: 17)
                                                  : TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 17),
                                            ),
                                      trailing: Icon(
                                          Icons.arrow_right_alt_sharp,
                                          size: 35),
                                    ),
                                  ),
                                ))
                            .toList());
                  } else if (snapshot.hasError) {
                    return Text('Sorry Seems There is An Error. Plese report');
                    // ignore: unnecessary_null_comparison
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }))
      ]),
    );
  }
}
