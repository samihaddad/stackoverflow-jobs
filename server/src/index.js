const { ApolloServer } = require('apollo-server');
const typeDefs = require('./schema');
const resolversSrc = require('./resolvers');
const JobAPI = require('./datasources/job');
const { dateScalar } = require('./custom_types');

const resolvers = {
  Date: dateScalar,
  ...resolversSrc
}

const dataSources = () => ({
  jobAPI: new JobAPI(),
});

const myPlugin = {

  // Fires whenever a GraphQL request is received from a client.
  requestDidStart(requestContext) {
    console.log('Request started [Query]:\n' +
      requestContext.request.query);

    return {

      // Fires whenever Apollo Server will parse a GraphQL
      // request to create its associated document AST.
      parsingDidStart(requestContext) {
        console.log('Parsing started');
      },

      // Fires whenever Apollo Server will validate a
      // request's document AST against your GraphQL schema.
      validationDidStart(requestContext) {
        console.log('Validation started');
      },

    }
  },
};


const server = new ApolloServer({
  typeDefs,
  resolvers,
  dataSources,
  plugins: [
    myPlugin
  ]
});

server.listen().then(() => {
  console.log(`
    Server is running!
    Listening on port 4000
  `);
});
