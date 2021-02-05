const { paginateResults } = require('./utils');

module.exports = {
  Query: {
    jobFeed: async (_, { pageSize = 20, after }, { dataSources }) => {
      const allJobs = await dataSources.jobAPI.getJobs();
      allJobs.sort((a, b) => b.publishDate - a.publishDate);
      const jobs = paginateResults({
        after,
        pageSize,
        results: allJobs,
      })
      return {
        jobs,
        totalCount: allJobs.length,
        pageInfo: {
          cursor: jobs.length ? jobs[jobs.length - 1].cursor : null,
          hasMore: jobs.length
            ? jobs[jobs.length - 1].cursor !==
            allJobs[allJobs.length - 1].cursor
            : false,
        }
      };
    },
  },
};