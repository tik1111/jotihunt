



import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jotihunt/services/authservice.dart';
import 'package:jotihunt/services/locationservice.dart';

class DatabaseHandler{
  
  //Define Auth service to access user
  final AuthenticationService _auth = new AuthenticationService();

  final LocationService _locationService =  new LocationService();

  //Database reference
  final databaseReference = Firestore.instance;

  //Define collections in database
  final String locationCollection = 'Locations';


  Future<FirebaseUser> getCurrentUserUid()async {
    //Get current logged in user from authentication service.   
    try{
      return await _auth.getCurrentUserUid();
    }catch (errorMessage){
      return errorMessage;
    }
  }

  void writeUserLocation()async {
      //Get firebase user and subtrack uid from it
      FirebaseUser firebaseUser = await getCurrentUserUid();
      String uid =  firebaseUser.uid;

      //Get user location in position object
      var userLocation = await _locationService.getGeoLocation();

      //Try to write database User, long , lat
      try{
     
        await databaseReference.collection(locationCollection).document(uid).setData({
            'User': '${uid}',
            'Long': userLocation.longitude,
            'Lat' : userLocation.latitude
            });
            
      }catch (errorMessage){
          //! todo error handling on failure
      }

  }


  void readUserLocation(){

  }


  void writeHuntLocation(){

  }


  void readHuntLocation(){

  }


  void writeSpotLocation(){

  }


  void readSpotLocation(){
    
  }


}