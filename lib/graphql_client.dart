import 'package:graphql_flutter/graphql_flutter.dart';

final HttpLink _httpLink = HttpLink(
  'http://localhost:4000',
);

final GraphQLClient _client = GraphQLClient(
  cache: GraphQLCache(),
  link: _httpLink,
);

GraphQLClient client = _client;
