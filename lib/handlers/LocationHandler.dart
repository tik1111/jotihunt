import 'dart:html';

import 'package:location/location.dart';

class LocationHandler {
  Future<bool> verifyLocationPermissionAndServiceAcitve() async {
    Location location = new Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }

    permissionGranted = await location.hasPermission();

    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }

    return true;
  }

  Future<LocationData> getLastKnowLocationOfCurrentUser() async {
    Location location = Location();
    LocationData locationData;

    bool isLocationPermissionGranted =
        await verifyLocationPermissionAndServiceAcitve();

    if (isLocationPermissionGranted) {
      locationData = await location.getLocation();
      return locationData;
    }

    throw Error();
  }
}
