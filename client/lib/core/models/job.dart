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

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      company: json['company'] as String,
      link: json['link'] as String,
      publishDate:
          DateTime.fromMillisecondsSinceEpoch(json['publishDate'] as int),
      location: json['location'] as String,
      category: json['category'].cast<String>(),
    );
  }

  static List<Job> fromJsonArray(List json) {
    return json.map((job) => Job.fromJson(job)).toList();
  }
}
