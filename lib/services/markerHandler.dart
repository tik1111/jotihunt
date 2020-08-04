import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jotihunt/services/authservice.dart';
import 'package:jotihunt/services/locationservice.dart';


class MarkerHandler{

  final databaseReference = Firestore.instance;
  final AuthenticationService _auth = new AuthenticationService();
  final LocationService _locationService =  new LocationService();

  BitmapDescriptor customIcon;
  

 
  //void createLocationRecord() async{
//
  //    FirebaseUser user = await _auth.getCurrentUserUid();
  //    
  //    var userLocation = await _locationService.getGeoLocation();      
  //    
  //    if(databaseReference.collection('Locations').document(user.uid) != null){
//
  //      databaseReference.collection('Locations').document(user.uid).updateData({
  //          'Long': userLocation.longitude,
  //          'Lat' : userLocation.latitude
  //          });
  //          
  //    }else{
  //   
  //      await databaseReference.collection('Locations').document(user.uid).setData(
  //        {
  //          'User': '${user.uid}',
  //          'Long': userLocation.longitude,
  //          'Lat' : userLocation.latitude
  //        }
  //      );
  //    }
  //}


  Future<BitmapDescriptor> getMarkerIcon()async{



  BitmapDescriptor customIcon;
  
  BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(12, 12)),"assets/car_icon_blue.png").then((d) {
  customIcon = d;
  });

      // var carImage = BitmapDescriptor.fromAssetImage(
      //ImageConfiguration(
      //  size: Size(1, 1)),
      //"assets/car_icon_blue.png");
      
      return customIcon;
  }
  
  
  
  Marker setSingleMarker(String markerID, LatLng position, String markerType){

    //! add image code
   

    return Marker(
      markerId: MarkerId(markerID),
      position: position,
      //icon: getMarkerIcon(), 
      draggable: false    
    );

  }

}