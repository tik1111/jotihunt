import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jotihunt/services/authservice.dart';
import 'package:jotihunt/services/locationservice.dart';


class MarkerHandler{

  final databaseReference = Firestore.instance;
  final AuthenticationService _auth = new AuthenticationService();
  final LocationService _locationService =  new LocationService();

  
  
  void createLocationRecord() async{

      FirebaseUser user = await _auth.getCurrentUserUid();
      
      var userLocation = await _locationService.getsUserLocation();      
      
      await databaseReference.collection('Locations').document(user.uid).setData(
        {
          'User': '${user.uid}',
          'Long': userLocation.longitude,
          'Lat' : userLocation.latitude
        }
      );

  }


  
     
  


  Future<Set<Marker>> getMarkers() async{
    Set<Marker> markerSet = new Set();


    var carImage = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(
          size: Size(1, 1)),
        "assets/car_icon_blue.png");


    await databaseReference.collection('Locations').getDocuments().then((querySnapshot){

      querySnapshot.documents.forEach((result) {
        markerSet.add(
          Marker(
            markerId: MarkerId(result.data['User']),
            position: LatLng(result.data['Lat'],result.data['Long']),
            icon: carImage,
            
            draggable: false 
          )
        );
      });
    });
    return markerSet;
  }
}