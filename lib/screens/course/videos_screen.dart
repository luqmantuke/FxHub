import 'package:flutter/material.dart';

class VideosScreen extends StatefulWidget {
  final String courseId;
  const VideosScreen({Key? key, required this.courseId}) : super(key: key);

  @override
  _VideosScreenState createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent.withOpacity(1),
        title: Text("Videos"),
        centerTitle: true,
      ),
    );
  }
}
