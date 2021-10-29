class CourseModel {
  String courseName;
  String courseDetails;
  String courseImage;
  String courseUrl;
  bool hasPdf;
  bool hasVideo;
  CourseModel(
      {required this.courseDetails,
      required this.courseImage,
      required this.courseUrl,
      required this.hasPdf,
      required this.hasVideo,
      required this.courseName});

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      courseDetails: map['courseDetails'] ?? '',
      courseImage: map['courseImage'] ?? '',
      courseName: map['courseName'] ?? '',
      hasPdf: map['hasPdf'] ?? true,
      hasVideo: map['hasVideo'] ?? true,
      courseUrl: map['courseUrl'] ?? '',
    );
  }
}
