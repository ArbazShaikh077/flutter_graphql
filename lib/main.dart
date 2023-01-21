import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'graphql_client.dart';
import 'graphql_provider.dart' as provider;

void main() {
  runApp(provider.GraphQLProvider(
    client: client,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String serverData = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getDataFromGraphQL();
    super.didChangeDependencies();
  }

  void getDataFromGraphQL() async {
    const String query = """
  query {
    hello
  }
""";

    final QueryOptions options = QueryOptions(
      document: gql(query),
    );

    final QueryResult result =
        await provider.GraphQLProvider.of(context).query(options);

    if (result.hasException) {
      print("Exception occred while reading the data ${result.exception}");

      // Handle errors
    } else {
      print("Successfully get the data");
      final String? joke = result.data?["hello"];
      setState(() {
        serverData = joke ?? "";
      });
      // Do something with the data
      print("$joke  ${result.timestamp}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              serverData,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
