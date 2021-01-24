import 'package:intl/intl.dart';

class Job {
  String id;
  String title;
  String description;
  String company;
  String link;
  DateTime publishDate;
  String location;
  List<String> category;

  Job({
    this.id,
    this.title,
    this.description,
    this.company,
    this.link,
    this.publishDate,
    this.location,
    this.category,
  });

  factory Job.fromMap(Map<String, dynamic> map) {
    return Job(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      company: map['company'] as String,
      link: map['link'] as String,
      publishDate:
          DateTime.fromMillisecondsSinceEpoch(map['publishDate'] as int),
      location: map['location'] as String,
      category: map['category'].cast<String>(),
    );
  }
}
