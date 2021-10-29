import 'package:flutter/material.dart';

class NotesScreen extends StatefulWidget {
  final String courseId;
  const NotesScreen({Key? key, required this.courseId}) : super(key: key);

  @override
  _VideosScreenState createState() => _VideosScreenState();
}

class _VideosScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent.withOpacity(1),
        title: Text("NOTES"),
        centerTitle: true,
      ),
    );
  }
}
