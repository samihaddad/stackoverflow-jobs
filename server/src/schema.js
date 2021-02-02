const { gql } = require('apollo-server');

const typeDefs = gql`
  scalar Date
  
  type Query {
    jobFeed(
      pageSize: Int
      after: String
    ): JobFeed!
  }

  type Job {
    id: ID!
    title: String
    description: String
    publishDate: Date
    link: String
    company: String
    category: [String]
    location: String
  }

  type JobFeed {
    totalCount: Int!
    jobs: [Job]!
    pageInfo: PageInfo!
  }

  type PageInfo {
    cursor: String!
    hasMore: Boolean!
  }

`;

module.exports = typeDefs;
