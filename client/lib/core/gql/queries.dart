const String getJobs = r'''
  query GetJobs($pageSize: Int, $after: String) {
    jobFeed(pageSize: $pageSize, after: $after) {
      totalCount
      jobs {
        title
        description
        link
        publishDate
        location
        category
        company
      }
      pageInfo {
        cursor
        hasMore
      }
    }
  }
  ''';
