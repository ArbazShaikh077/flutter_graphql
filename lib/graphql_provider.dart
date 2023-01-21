import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLProvider extends InheritedWidget {
  final GraphQLClient client;

  const GraphQLProvider({Key? key, required Widget child, required this.client})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(GraphQLProvider oldWidget) =>
      client != oldWidget.client;

  static GraphQLClient of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<GraphQLProvider>()
              as GraphQLProvider)
          .client;
}
