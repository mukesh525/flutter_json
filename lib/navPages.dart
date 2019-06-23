import 'package:flutter/material.dart';

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: color,
      child: new Center(
          child: RaisedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('Press here'),
      )),
    );
  }
}
