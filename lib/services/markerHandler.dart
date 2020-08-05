import 'dart:developer';

import 'package:google_maps_flutter/google_maps_flutter.dart';



class MarkerHandler{
 
  
  Marker setHunterMarker(String markerID, LatLng position, String vehicleType){
    
    //!CHANGE FUNCTION TO USER MARKER AND CREATE HUNT AND SPOT MARKER ASWELL

    //String holder for image path based on vehicle type.
    String iconImage;


    //Switch betreen vehicle types
    switch(vehicleType){
      case "car":{
        iconImage = "assets/car.png";
        log("case car");
        break;
      }
        
      case "bike":{
        iconImage = "assets/bike.png";
        break;
      }

      case "skateboard":{
        iconImage = "assets/skateboard.png";
        break;
      }

      default:{
        iconImage = "assets/car.png";
        log("case default");
        break;
      } 

    }

    return Marker(
      markerId: MarkerId(markerID),
      position: position,
      icon: BitmapDescriptor.fromAsset(iconImage), 
      draggable: false    
    );

  }

}