import 'package:flutter/material.dart';
import 'package:flutter_json/pages.dart';

import 'API.dart';
import 'models/Users.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Http App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/HomeScreen': (BuildContext context) => new MyListScreen(),
        '/a': (BuildContext context) => SecondPage(null)
      },
    );
  }
}

class MyListScreen extends StatefulWidget {
  @override
  createState() => _MyListScreenState();
}

class _MyListScreenState extends State {
  var users = new List<Welcome>();

  // The GlobalKey keeps track of the visible state of the list items
  // while they are being animated.
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  // This is the animated row with the Card.
  Widget _buildItem(String item, Animation animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        child: ListTile(
          title: Text(
            item,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  _getUsers() {
    API.getUsers().then((response) {
      setState(() {
        users = welcomeFromJson(response.body);
        // users = list.map((model) => User.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getUsers();
  }

  dispose() {
    super.dispose();
  }

  @override
  build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("User List"),
        ),
        drawer: Drawer(
            child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: new BoxDecoration(color: const Color(0xFF00897b)),
              accountName: Text("Mukesh Jha"),
              accountEmail: Text("mukeshjha2007@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? Colors.blue
                        : Colors.white,
                child: Text(
                  "M",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              title: Text("Ttem 1"),
//              onTap: () {
//                Navigator.of(context).pop();
//                Navigator.of(context).push(MaterialPageRoute(
//                    builder: (BuildContext context) => NewPage("Page two")));
//              },
              trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              title: Text("Item 2"),
              trailing: Icon(Icons.arrow_forward),
            ),
          ],
        )),
        body: ListView.builder(
          key: _listKey,
          itemCount: users.length,
          itemBuilder: (context, index) {
            return Card(
                child: ListTile(
                    title: Text(users[index].name),
                    onTap: () {
                      debugPrint(users[index].name);
//                      setState(() {
//                        users[index].name = "Mukesh";
//                      });
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new SecondPage(users)));

                      //Navigator.pushNamed(context, '/a',arguments: users);
                    },
                    onLongPress: () {
                      //                            <-- onLongPress
                      setState(() {
                        users.removeAt(index);
                      });
                    },
                    subtitle: Text(users[index].company.name),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    leading: Icon(Icons.wb_sunny)));
          },
        ));
  }
}
