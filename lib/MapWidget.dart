import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_json/models/Users.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  final List<Welcome> users;

  MapsPage({Key key, @required this.users}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MapsPage> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = Set();
  static const LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    widget.users.forEach((element) => debugPrint(element.name));

    widget.users.forEach((element) => {
          markers.add(Marker(
              markerId: MarkerId(element.id.toString()),
              position: element.address.geo.Location(),
              infoWindow: new InfoWindow(
                title: element.name,
                snippet: element.address.city,
              )))
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}
