import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import './feedback.dart';


// import 'package:http/http.dart' as http;
import './model/datamodel.dart';

// import 'dart:async';
import 'package:http/http.dart' show Client;

class MembersScreen extends StatefulWidget {
  @override
  _MembersScreenState createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  String _fbUrl =
      "https://graph.facebook.com/v8.0/me?fields=id%2Cname%2Cposts%7Bmessage%2Cpicture%7D&access_token=EAAzzbcIw7QgBAFqEVdsjPtTAPrVceCU2GC7T1AnuTFQkPVBDPhkGtxXHTpoCZAUb4vMvtLonpWyWTimLTYnzKK7jtEWpvgNEZBFj5T3hV02EjeN8d6Ege2GF5WVogM5T0UakRCZBJZBuguKDlB24nByqNqpfXapdaZCY6j3ayKzXaeSOYTyXK8Qzl7eH6C0gZD";

  List<FBData> fbData = [];
  Client client = Client();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDBData();
  }

  Future fetchDBData() async {
    try {
      final response = await client.get(_fbUrl);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("Success");
        Iterable l = json.decode(response.body)['posts']['data'];
        setState(() {
          fbData = l.map((i) => FBData.fromJson(i)).toList();
        });
      } else {
        print("Failed");
      }
    } catch (_) {
      return await serverFailed;
    }
    return await serverFailed;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: choices.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Members Pannel'),
            backgroundColor: Colors.green,
            bottom: TabBar(
              tabs: choices.map((Choice choice) {
                return Tab(
                  text: choice.title,
                  icon: Icon(choice.icon),
                );
              }).toList(),
            ),
          ),
          body: TabBarView(
            children: choices.map((Choice choice) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: ChoiceCard(choice: choice, data: fbData),
              );
            }).toList(),
          ),

          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
            DrawerHeader(
            child: Container(
              child: ListView(
              children: <Widget>[
              Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            ListTile(
              leading: Icon(Icons.perm_identity, size: 100.0),
            ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.green,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/images/cover.jpg'),
          ),
        ),
      ),
      ListTile(
        leading: Icon(
          Icons.home,
          color: Colors.green,
        ),
        title: Text('Home'),
        onTap: () => {},
      ),
      ListTile(
          leading: Icon(
            Icons.verified_user,
            color: Colors.green,
          ),
          title: Text('Profile'),
          onTap: () => {Navigator.of(context).pop()},
    ),

    ListTile(
    leading: Icon(
    Icons.settings,
    color: Colors.green,
    ),
    title: Text('Settings'),
    onTap: () => {Navigator.of(context).pop()},
    ),
    ListTile(
    leading: Icon(
    Icons.border_color,
    color: Colors.green,
    ),
    title: Text('Feedback'),
    onTap: () => {

    Navigator.push(context,
    MaterialPageRoute(builder: (context) => Feeedback()))
    },
    ),
    ListTile(
    leading: Icon(
    Icons.exit_to_app,
    color: Colors.green,
    ),
    title: Text('Logout'),
    onTap: () => {Navigator.of(context).pop()},
    ),
    ],
    ),
    ),
    ),
    ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Home', icon: Icons.home),
  const Choice(title: 'Notification', icon: Icons.notification_important),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice, this.data}) : super(key: key);

  final Choice choice;
  final List<FBData> data;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.headline;
    if (choice.title == 'Home') {
      return Card(
        color: Colors.white,
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) => _buildListItem(context, data[index]),
        ),
      );
    } else {
      return Card(
        color: Colors.white,
      );
    }
  }
}

Widget _buildListItem(context, FBData data) {
  var message = data.message == null ? "" : data.message;
  var full_picture = data.full_Picture == null ? "" : data.full_Picture;

  return Container(
    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
    padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Colors.grey,
          width: 5.0,
        ),
        right: BorderSide(
          color: Colors.grey,
          width: 2.0,
        ),
        left: BorderSide(
          color: Colors.grey,
          width: 2.0,
        ),
      ),
    ),
    child: Column(
      children: <Widget>[
        Text(
            message,
            style: TextStyle(
//            fontSize: 18,
            )
        ),
        SizedBox(height: 10),
        Image.network(
            full_picture,
            cacheWidth: 280,
            cacheHeight: 300
        ),
        SizedBox(height: 10),
      ],
    ),
  );
}
