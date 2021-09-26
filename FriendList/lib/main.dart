import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:friend_list/models/Friend.dart';
import 'package:friend_list/views/Details.dart';
import 'package:friend_list/views/HomePage.dart';

Future<List<Friend>> fetchFriends() async {
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
        friendList.map((friend) => Friend.fromJson(friend)).toList();

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
      title: 'Friend Lists',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Friend>> friends;

  @override
  void initState() {
    setState(() {
      super.initState();
    });
    friends = fetchFriends();
  }

  void _pushDetails(Friend friend) {
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
    return HomePage(friends: friends, buttonAction: _pushDetails);
  }
}
