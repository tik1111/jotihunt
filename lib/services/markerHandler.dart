import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jotihunt/services/authservice.dart';
import 'package:jotihunt/services/locationservice.dart';


class MarkerHandler{

  final databaseReference = Firestore.instance;
  final AuthenticationService _auth = new AuthenticationService();
  final LocationService _locationService =  new LocationService();

  
  
  void createLocationRecord() async{

      FirebaseUser user = await _auth.getCurrentUserUid();
      
      var userLocation = await _locationService.getGeoLocation();      
      
      await databaseReference.collection('Locations').document(user.uid).setData(
        {
          'User': '${user.uid}',
          'Long': userLocation.longitude,
          'Lat' : userLocation.latitude
        }
      );
  }





  Marker setSingleMarker(String markerID, LatLng position, String markerType){

    //! add image code
       // var carImage = await BitmapDescriptor.fromAssetImage(
   //     ImageConfiguration(
   //       size: Size(1, 1)),
   //     "assets/car_icon_blue.png");

    return Marker(
      markerId: MarkerId(markerID),
      position: position,
      draggable: false    
    );

  }

}