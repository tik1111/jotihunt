
import 'package:location/location.dart';

class LocationService{


Location location = new Location();
LocationData _location;



Future<LocationData> getsUserLocation() async{

  _location = await location.getLocation();
  return(_location);
  
}







}