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
  GoogleMapController mapController;
  Set<Marker> markers = Set();
  LatLng _center = const LatLng(12.972442, 77.580643);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _controller.complete(controller);

    controller.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(48.8589507, 2.2770205),
          northeast: LatLng(50.8550625, 4.3053506),
        ),
        32.0,
      ),
    );
    setState(() {
      widget.users.forEach((element) => {
            debugPrint(element.name),
            markers.add(Marker(
                markerId: MarkerId(element.id.toString()),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                position: element.address.geo.Location(),
                infoWindow: new InfoWindow(
                  title: element.name,
                  snippet: element.address.city,
                )))
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        child: GoogleMap(
          markers: markers,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),

      )
    );
  }
}
