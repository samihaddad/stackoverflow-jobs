import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:so_jobs/core/models/job_feed.dart';
import 'package:so_jobs/core/gql/queries.dart' as queries;

class JobService {
  JobService(this._client);

  final GraphQLClient _client;

  Future<JobFeed> getJobs({int pageSize = 20, String after}) async {
    final result = await _client.query(QueryOptions(
      documentNode: gql(queries.getJobs),
      variables: <String, dynamic>{
        'pageSize': pageSize,
        'after': after,
      },
    ));
    if (result.hasException) {
      throw result.exception;
    }
    return JobFeed.fromJson(result.data['jobFeed']);
  }
}
