import 'package:so_jobs/core/models/job.dart';

class JobListState {
  final List<Job> itemList;
  final dynamic error;
  final String nextPageKey;

  JobListState({
    this.itemList,
    this.error,
    this.nextPageKey,
  });
}
