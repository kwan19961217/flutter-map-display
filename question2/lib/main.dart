import 'dart:io';
import 'package:ex2/view/Details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ex2/model/Friends.dart';

Future<List<Friends>> fetchFriends() async {
  final response = await http.get(
      Uri.parse('https://api.json-generator.com/templates/Xp8zvwDP14dJ/data'),
      headers: {
        HttpHeaders.authorizationHeader:
            'Bearer v3srs6i1veetv3b2dolta9shrmttl72vnfzm220z'
      });

  if (response.statusCode == 200) {
    final List<dynamic> friendList = jsonDecode(response.body);
    print(friendList);
    final cleanList =
        friendList.map((friend) => Friends.fromJson(friend)).toList();

    return cleanList;
  } else
    throw Exception('Failed to load Friends.');
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moovup Programming Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'All Friends'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Friends>> friends;

  @override
  void initState() {
    setState(() {
      super.initState();
    });
    friends = fetchFriends();
  }

  void _pushDetails(Friends friend) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Details(
          name: '${friend.firstName} ${friend.lastName}',
          latitude: friend.latitude,
          longitude: friend.longitude);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: FutureBuilder<List<Friends>>(
              future: friends,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      String name =
                          '${snapshot.data![index].firstName} ${snapshot.data![index].lastName}';

                      return Card(
                          child: ListTile(
                              leading: Icon(Icons.account_circle,
                                  color: Colors.blue, size: 32),
                              title: Text(name, style: TextStyle(fontSize: 18)),
                              onTap: () {
                                _pushDetails(snapshot.data![index]);
                              }));
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else {
                  return Text('false');
                }
              })),
    );
  }
}
