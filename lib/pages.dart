import 'package:flutter/material.dart';

import 'models/MapWidget.dart';
import 'navPages.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('First Page'),
        ),
        body: new Center(
          child: RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new SecondPage()));
            },
            child: Text('Press here'),
          ),
        ));
  }
}

class SecondPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new SecondPageState();
  }
}

class SecondPageState extends State<SecondPage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    MapsPage(),
    PlaceholderWidget(Colors.deepOrange),
    PlaceholderWidget(Colors.green)
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Second Page'),
        ),
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(

          onTap: onTabTapped, // new
          currentIndex: _currentIndex, // new
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.mail),
              title: new Text('Messages'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), title: Text('Profile'))
          ],
        )
    );
  }



  Widget build1(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Flutter App'),
      ),
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            title: Text('Messages'),
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile')
          )
        ],
      ),
    );
  }
}
