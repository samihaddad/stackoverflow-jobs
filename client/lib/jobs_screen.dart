import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:so_jobs/queries.dart' as queries;
import 'package:so_jobs/job.dart';
import 'package:so_jobs/job_details_screen.dart';
import 'package:so_jobs/job_list_tile.dart';

class JobsScreen extends StatefulWidget {
  JobsScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _JobsScreenState createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ''),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Query(
          options: QueryOptions(
            documentNode: gql(queries.getJobs),
            // pollInterval: 10,
            variables: {
              'after': null,
            },
          ),
          builder: (QueryResult result,
              {VoidCallback refetch, FetchMore fetchMore}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }
            if (result.loading && result.data == null) {
              return Center(child: CircularProgressIndicator());
            }

            final Map jobFeed = result.data['jobFeed'];
            final Map pageInfo = jobFeed['pageInfo'];
            final bool hasMore = pageInfo['hasMore'] as bool;
            final res = jobFeed['jobs'] as List;
            final String cursor = pageInfo['cursor'];
            final opts = FetchMoreOptions(
              variables: {'after': cursor},
              updateQuery: (previousResultData, fetchMoreResultData) {
                final repos = [
                  ...previousResultData['jobFeed']['jobs'] as List<dynamic>,
                  ...fetchMoreResultData['jobFeed']['jobs'] as List<dynamic>
                ];
                fetchMoreResultData['jobFeed']['jobs'] = repos;
                return fetchMoreResultData;
              },
            );

            final List<Job> jobs = res.map((job) => Job.fromMap(job)).toList();
            return Column(
              children: [
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent && !result.loading) {
                        fetchMore(opts);
                      }
                      return false;
                    },
                    child: ListView.separated(
                      itemCount: jobs.length,
                      separatorBuilder: (_, __) => SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final job = jobs[index];
                        return JobListTile(
                          job: job,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => JobDetailScreen(job: job)));
                          },
                        );
                      },
                    ),
                  ),
                ),
                if (result.loading)
                  CircularProgressIndicator(),
              ],
            );
          },
        ),
      ),
    );
  }
}
