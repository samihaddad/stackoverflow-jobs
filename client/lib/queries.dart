const String getJobs = r'''
  query GetJobs($after: String) {
    jobFeed(after: $after) {
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
