import 'dart:async';
import 'package:dio/dio.dart';
import 'package:jotihunt/handlers/handler_secure_storage.dart';
import 'package:jotihunt/handlers/handler_webrequests.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LocationHandler {
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

  Future<List<dynamic>> getFoxLocationsToList() async {
    try {
      Dio dio = HandlerWebRequests.dio;

      String? gameId = await SecureStorage().getCurrentSelectedGame();

      Response allFoxLocationJson = await dio.get(
          '${dotenv.env['API_ROOT']!}/fox',
          queryParameters: {"game_id": gameId});

      List allFoxLocationList = allFoxLocationJson.data;

      return allFoxLocationList;
    } catch (e) {
      return [];
    }
  }

  Future<DateTime> getLastLocationByArea(
    String area,
  ) async {
    List<dynamic> initialList = await getFoxLocationsToList();
    List<Map<String, dynamic>> data = List.from(initialList);

    var filteredData = data
        .where((map) => map['area'] == area && map['type'] == 'hunt')
        .toList();

    if (filteredData.isEmpty) {
      return DateTime.now();
    }

    filteredData.sort((a, b) => DateTime.parse(b['created_at'])
        .compareTo(DateTime.parse(a['created_at'])));

    return DateTime.parse(filteredData.first['created_at']);
  }

  Future<bool> addHuntOrSpot(LatLng latLng, String huntOrSport) async {
    try {
      var dio = HandlerWebRequests.dio;

      String? gameId = await SecureStorage().getCurrentSelectedGame();
      String? activeArea = await SecureStorage().getCurrentSelectedArea();

      Map<String, dynamic> formMap = {
        "game_id": gameId,
        "area": activeArea,
        "type": huntOrSport,
        "lat": latLng.latitude,
        "long": latLng.longitude
      };

      await dio.post('${dotenv.env['API_ROOT']!}/fox',
          data: formMap,
          options: Options(contentType: Headers.formUrlEncodedContentType));

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
