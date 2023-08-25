import 'package:dio/dio.dart';
import 'package:jotihunt/handlers/handler_secure_storage.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LocationHandler {
  var dio = Dio();
  Future<bool> verifyLocationPermissionAndServiceAcitve() async {
    Location location = Location();

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

  Future<bool> addHuntOrSpot(LatLng latLng, String huntOrSport) async {
    try {
      dio.options.headers['x-access-token'] =
          await SecureStorage().getAccessToken();

      String? gameId = await SecureStorage().getCurrentSelectedGame();

      Map<String, dynamic> formMap = {
        "game_id": gameId,
        "area": "Alpha", //! create area selector
        "type": huntOrSport,
        "lat": latLng.latitude,
        "long": latLng.longitude
      };

      await dio.post('${dotenv.env['API_ROOT']!}/fox', data: formMap);

      return false;
    } on DioException catch (dioError) {
      // ignore: avoid_print
      print(dioError.response!.data.toString());
      return false;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return false;
    }
  }
}
