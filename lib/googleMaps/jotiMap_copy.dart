import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jotihunt/services/markerHandler.dart';





class JotiMap_test extends StatefulWidget {
  @override
  _JotiMapState createState() => _JotiMapState();
}

class _JotiMapState extends State<JotiMap_test> {
  
  MarkerHandler _markerHandler = new MarkerHandler();

  MapType _defaultMapType = MapType.normal;
  
  GoogleMapController _googleMapController;
  
  Set<Marker> allMarkers = {};
  
  Timer timer;

  Stream<QuerySnapshot> _locationUpdateStream = Firestore.instance.collection("Locations").snapshots();




  @override
  void initState() { 
    super.initState();
    var geolocator = Geolocator();
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
    geolocator.getPositionStream(locationOptions).listen(
        (Position position) {
            print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
            
            _markerHandler.createLocationRecord();
        });
           
  }


  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(51.949976, 6.319906),
    zoom: 10.4746,
    
  );


  void _onMapCreated(GoogleMapController controller){
    setState(() {
      _googleMapController = controller; 
     
    });
     
    
  }

  void _changeMapType() {
    setState(() {
      _defaultMapType = _defaultMapType == MapType.normal ? MapType.hybrid : MapType.normal;
    });
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _locationUpdateStream,
      builder:(context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot.data != null){
          snapshot.data.documents.forEach((marker) {
              print(marker.documentID.toString() + 'element');
              allMarkers.add(_markerHandler.setSingleMarker(marker.documentID, LatLng(marker.data['Lat'],marker.data['Long']), "car")
            );
          });
        }
      return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
                  mapType: _defaultMapType,
                    onMapCreated: _onMapCreated,
                  myLocationEnabled: true,
                  compassEnabled: true,
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  initialCameraPosition: initialLocation,  
                  markers: allMarkers, 
                ),
        );
      }
    );
  }

}

