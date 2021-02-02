import 'package:so_jobs/core/models/job.dart';

class JobFeed {
  List<Job> jobs;
  int totalCount;
  PageInfo pageInfo;

  JobFeed({
    this.jobs,
    this.totalCount,
    this.pageInfo,
  });

  factory JobFeed.fromJson(Map<String, dynamic> json) {
    return JobFeed(
      jobs: Job.fromJsonArray(json['jobs']),
      totalCount: json['totalCount'] as int,
      pageInfo: PageInfo.fromJson(json['pageInfo']),
    );
  }
}

class PageInfo {
  String cursor;
  bool hasMore;

  PageInfo({
    this.cursor,
    this.hasMore,
  });

  factory PageInfo.fromJson(Map<String, dynamic> json) {
    return PageInfo(
      cursor: json['cursor'] as String,
      hasMore: json['hasMore'] as bool,
    );
  }
}
