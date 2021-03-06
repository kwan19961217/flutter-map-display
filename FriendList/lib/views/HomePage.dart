import 'package:flutter/material.dart';
import 'package:friend_list/models/Friend.dart';

class HomePage extends StatelessWidget {
  final _friends;
  final _buttonAction;

  const HomePage({friends, buttonAction, Key? key})
      : _friends = friends,
        _buttonAction = buttonAction,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Friends'),
      ),
      body: Center(
          child: FutureBuilder<List<Friend>>(
              future: _friends,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final friendlist = snapshot.data!;
                  return ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: friendlist.length,
                    itemBuilder: (BuildContext context, int index) {
                      String name =
                          '${friendlist[index].firstName} ${friendlist[index].lastName}';
                      return Card(
                          child: ListTile(
                              leading: Icon(Icons.account_circle,
                                  color: Colors.blue, size: 32),
                              title: Text(name, style: TextStyle(fontSize: 18)),
                              onTap: () {
                                _buttonAction(friendlist[index]);
                              }));
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else {
                  return Text('Loading...');
                }
              })),
    );
  }
}
