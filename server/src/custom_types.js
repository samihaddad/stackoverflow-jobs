const { GraphQLScalarType, Kind } = require('graphql');

module.exports.dateScalar = new GraphQLScalarType({
  name: 'Date',
  description: 'Date custom scalar type',
  serialize(value) {
    return value.getTime();
  },
});