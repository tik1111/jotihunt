import 'package:geolocator/geolocator.dart';

class LocationService{

Geolocator geolocator = new Geolocator();



Future <Position> getGeoLocation() async{

  Position position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
  return(position);

}


}