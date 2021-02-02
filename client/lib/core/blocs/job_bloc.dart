import 'package:rxdart/subjects.dart';
import 'package:so_jobs/core/models/job.dart';
import 'package:so_jobs/core/models/job_list_state.dart';
import 'package:so_jobs/core/services/job_service.dart';

class JobBloc {
  JobBloc({this.service}) {
    _pageRequestSubject.listen((c) {
      queryJobs(cursor: c);
    });
  }
  JobService service;

  final _jobListStateSubject =
      BehaviorSubject<JobListState>.seeded(JobListState());
  final _pageRequestSubject = BehaviorSubject<String>();

  Stream<JobListState> get jobListStateStream => _jobListStateSubject.stream;

  JobListState get jobListState => _jobListStateSubject.value;

  Sink<String> get onPageRequestSink => _pageRequestSubject.sink;

  Future<void> queryJobs({String cursor}) async {
    final lastState = jobListState;
    try {
      final feed = await service.getJobs(after: cursor);
      final allJobs = <Job>[
        ...lastState.itemList ?? [],
        ...feed.jobs,
      ];
      _jobListStateSubject.add(JobListState(
        itemList: allJobs,
        nextPageKey: feed.pageInfo.hasMore ? feed.pageInfo.cursor : null,
      ));
    } catch (e) {
      _jobListStateSubject.add(JobListState(
        error: e,
        nextPageKey: lastState.nextPageKey,
        itemList: lastState.itemList,
      ));
    }
  }

  void dispose() {
    _jobListStateSubject?.close();
    _pageRequestSubject?.close();
  }
}
