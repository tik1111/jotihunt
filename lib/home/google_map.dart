import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';



class MyGoogleMap extends StatefulWidget {
  @override
  _MyGoogleMapState createState() => _MyGoogleMapState();
}

class _MyGoogleMapState extends State<MyGoogleMap> {
  GoogleMapController mapController;
  Location _currentLocation;



  final LatLng _center = const LatLng(51.949325, 6.320033);

  @override
  void initState() {
    checkLocation();
  }

  Future<bool> checkLocation() async{
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    Location location = new Location();

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return true;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return true;
      }
    }

    _locationData = await location.getLocation();

  }



  void _onMapCreated(GoogleMapController controller){

    mapController = controller;
     _currentLocation.onLocationChanged.listen((l) {
      mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(l.longitude, l.longitude), zoom: 15
        ),
        ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
        initialCameraPosition: CameraPosition(target: _center, zoom: 15.0),
          
      ),

    floatingActionButton: FloatingActionButton(
      onPressed: (){

      },
      child: Icon(Icons.my_location),
    ),
    );
  }
}

