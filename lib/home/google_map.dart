import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MyGoogleMap extends StatefulWidget {
  @override
  _MyGoogleMapState createState() => _MyGoogleMapState();
}

class _MyGoogleMapState extends State<MyGoogleMap> {
  GoogleMapController mapController;
  final LatLng _center = const LatLng(51.949325, 6.320033);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(target: _center, zoom: 15.0),
          
      ),

    floatingActionButton: FloatingActionButton(
      onPressed: null,
      child: Icon(Icons.my_location),
    ),
    );
  }
}

