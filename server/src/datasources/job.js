const { RESTDataSource } = require('apollo-datasource-rest');
const parseStringPromise = require('xml2js').parseStringPromise;

class JobAPI extends RESTDataSource {
  constructor() {
    super();
    this.baseURL = 'http://stackoverflow.com/jobs/';//?q=as&l=london&u=Km&d=20';
  }

  async getJobs() {
    const response = await this.get('feed');
    const converted = await parseStringPromise(response, { explicitArray: false, ignoreAttrs: true});
    const items = converted.rss.channel.item;
    console.log('Total Jobs:', converted.rss.channel['os:totalResults'])
    return Array.isArray(items)
      ? items.map(job => this.jobReducer(job))
      : [];
  }

  jobReducer(job) {
    return {
      id: job.guid || 0,
      cursor: `${new Date(job.pubDate).getTime()}`,
      title: job.title,
      description: job.description,
      publishDate: new Date(job.pubDate),
      category: Array.isArray(job.category) ? job.category : [job.category],
      location: job.location,
      link: job.link,
      company: job['a10:author']['a10:name'],
    };
  }
}

module.exports = JobAPI;
