import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:so_jobs/core/blocs/job_bloc.dart';
import 'package:so_jobs/core/constants/api.dart';
import 'package:so_jobs/core/models/job.dart';
import 'package:so_jobs/core/services/job_service.dart';
import 'package:so_jobs/ui/screens/job_details_screen.dart';
import 'package:so_jobs/ui/widgets/job_list_tile.dart';

class JobsScreen extends StatefulWidget {
  @override
  _JobsScreenState createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  JobBloc _bloc;
  final _pagingController = PagingController<String, Job>(firstPageKey: null);

  @override
  void initState() {
    super.initState();
    final client = GraphQLClient(
      cache: NormalizedInMemoryCache(
        dataIdFromObject: typenameDataIdFromObject,
      ),
      link: HttpLink(
        uri: API.host,
      ),
    );
    _bloc = JobBloc(
      service: JobService(client),
    );

    _pagingController.addPageRequestListener((pageKey) async {
      _bloc.onPageRequestSink.add(pageKey);
    });

    _bloc.jobListStateStream.listen((state) {
      _pagingController.value = PagingState(
          itemList: state.itemList,
          nextPageKey: state.nextPageKey,
          error: state.error);
    });
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
        actions: [

        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(() => _pagingController.refresh()),
        child: Container(
          padding: EdgeInsets.all(15),
          child: PagedListView.separated(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Job>(
              itemBuilder: (context, job, index) => JobListTile(
                job: job,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => JobDetailScreen(job: job)));
                },
              ),
            ),
            separatorBuilder: (_, __) => SizedBox(
              height: 16,
            ),
          ),
        ),
      ),
    );
  }
}