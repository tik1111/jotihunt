import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jotihunt/screens/loading_screen.dart';
import 'package:jotihunt/services/markerHandler.dart';





class JotiMap extends StatefulWidget {
  @override
  _JotiMapState createState() => _JotiMapState();
}

class _JotiMapState extends State<JotiMap> {
  
  MarkerHandler handler = new MarkerHandler();

  MapType _defaultMapType = MapType.normal;
  
  GoogleMapController _googleMapController;
  
  Set<Marker> allMarkers;

  Future _future;

  Stream<QuerySnapshot> _locationUpdateStream = Firestore.instance.collection("Locations").snapshots();




  @override
  void initState() { 
    super.initState();
    var geolocator = Geolocator();
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

    StreamSubscription<Position> positionStream = geolocator.getPositionStream(locationOptions).listen(
        (Position position) {
            print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
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
      builder:(context, snapshot){
        if(snapshot.data != null){
          snapshot.data.documents.forEach((element) {
              _future = handler.updateAllMarkers();
              //! //!TODO remove print after document read optimisation.
            print(element.data['User']);
          });
        }
      
      return Scaffold(
        body: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder(
              future: _future,
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Loading();
                }
                Set<Marker>  markerList = snapshot.data;
                return  GoogleMap(
                  mapType: _defaultMapType,
                    onMapCreated: _onMapCreated,
                  myLocationEnabled: true,
                  compassEnabled: true,
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  initialCameraPosition: initialLocation,  
                  markers: markerList, 
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(onPressed: null,
              mini: true,
              child: Icon(Icons.my_location),
            ),
            FloatingActionButton(
              mini: true,
              child: Icon(Icons.map),
              onPressed: () {
                _changeMapType();
              }
            ),
          ],
          ),
          
        ]),
      );
      }
    );
    

    
  }

}

