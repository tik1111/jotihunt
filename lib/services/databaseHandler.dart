import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jotihunt/models/userProfileModel.dart';
import 'package:jotihunt/services/authservice.dart';
import 'package:jotihunt/services/locationservice.dart';

class DatabaseHandler{
  
  //Define Auth service to access user
  final AuthenticationService _auth = new AuthenticationService();

  //Define location service
  final LocationService _locationService =  new LocationService();

  //Database reference
  final _databaseReference = Firestore.instance;

  //Define collections in database
  final String locationCollection = 'Locations';
  final String userProfileCollection = 'Users';
  

  //Write userlocation to firebase
  void writeUserLocation()async {
      //Get firebase user and subtrack uid from it
      FirebaseUser firebaseUser = await _auth.getCurrentUser();
      String uid =  firebaseUser.uid;

      //Get user location in position object
      var userLocation = await _locationService.getGeoLocation();

      //Try to write database User, long , lat
      try{
     
        await _databaseReference.collection(userProfileCollection).document(uid).updateData({
            'long': userLocation.longitude,
            'lat' : userLocation.latitude
            });
            
      }catch (errorMessage){
          //! todo error handling on failure
      }
  }


  Future<DocumentSnapshot> readUserLocation()async{
    FirebaseUser firebaseUser = await _auth.getCurrentUser();
    String uid =  firebaseUser.uid;

    var userLocation = _databaseReference.collection(userProfileCollection).document(uid).get();

    return userLocation;
  }


  void writeHuntLocation(){

  }


  void readHuntLocation(){

  }


  void writeSpotLocation(){

  }


  void readSpotLocation(){
    
  }

  Future<bool> checkUserProfilePresenceOrCreate()async{
    FirebaseUser firebaseUser = await _auth.getCurrentUser();
    String uid =  firebaseUser.uid;
    
    await _databaseReference.collection(userProfileCollection).document(uid).get().then((DocumentSnapshot ds){

      if(ds.exists){
        log('Does exist' );
        return true;
      }else{
        UserProfileData _userProfileData = new UserProfileData();
        Firestore.instance.collection(userProfileCollection).document(uid).setData(_userProfileData.toMap());
        log('Doesnt exist' );
        return true;
    }
  });
  }



  void changeUserVehicle(String vehicle)async{
    //Get firebase user and subtrack uid from it
      FirebaseUser firebaseUser = await _auth.getCurrentUser();
      String uid =  firebaseUser.uid;

      try{
     
        await _databaseReference.collection(userProfileCollection).document(uid).updateData({
            'vehicle': vehicle,
            });
            
      }catch (errorMessage){
          //! todo error handling on failure
      }
  }


  Future<String> readUserVehicle()async{
    FirebaseUser firebaseUser = await _auth.getCurrentUser();
    String uid =  firebaseUser.uid;
    String userVehicle;

    await _databaseReference.collection(locationCollection).document(uid).get().then((DocumentSnapshot ds) => {
      userVehicle = ds.data['vehicle'],
    });

    return userVehicle;
  }

}