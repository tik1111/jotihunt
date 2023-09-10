import 'dart:async';
import 'package:dio/dio.dart';
import 'package:jotihunt/handlers/handler_secure_storage.dart';
import 'package:jotihunt/handlers/handler_webrequests.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LocationHandler {
  Future<List<dynamic>> getFoxLocationsToList(String area) async {
    try {
      Dio dio = HandlerWebRequests.dio;

      String? gameId = await SecureStorage().getCurrentSelectedGame();

      if (area.isNotEmpty) {
        Response allFoxLocationJson = await dio.get(
            '${dotenv.env['API_ROOT']!}/fox',
            queryParameters: {"game_id": gameId, "area": area});
        List allFoxLocationList = allFoxLocationJson.data;
        return allFoxLocationList;
      } else {
        Response allFoxLocationJson = await dio.get(
            '${dotenv.env['API_ROOT']!}/fox',
            queryParameters: {"game_id": gameId});

        List allFoxLocationList = allFoxLocationJson.data;
        return allFoxLocationList;
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<dynamic>> getLastFoxLocationByArea(String area) async {
    List<dynamic> initialList = await getFoxLocationsToList(area);
    List<Map<String, dynamic>> data = List.from(initialList);

    var filteredData = data
        .where((map) => map['area'] == area && map['type'] == 'hunt')
        .toList();
    return filteredData;
  }

  Future<DateTime> getLastLocationByAreaToCreatedAt(
    String area,
  ) async {
    var filteredData = await getLastFoxLocationByArea(area);

    if (filteredData.isEmpty) {
      return DateTime.now();
    }

    filteredData.sort((a, b) => DateTime.parse(b['created_at'])
        .compareTo(DateTime.parse(a['created_at'])));

    return DateTime.parse(filteredData.first['created_at']);
  }

  Future<bool> addHuntOrSpot(LatLng latLng, String huntOrSportOrHint,
      DateTime time, String huntCode) async {
    try {
      var dio = HandlerWebRequests.dio;

      String? gameId = await SecureStorage().getCurrentSelectedGame();
      String? activeArea = await SecureStorage().getCurrentSelectedArea();

      Map<String, dynamic> formMap = {
        "game_id": gameId,
        "area": activeArea,
        "type": huntOrSportOrHint,
        "lat": latLng.latitude,
        "long": latLng.longitude,
        "huntcode": huntCode,
        "hunt_time": time.toIso8601String()
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

  Future<List<dynamic>> getAllCurrentHunterLocations(String userId) async {
    Dio dio = HandlerWebRequests.dio;

    Response allUserLocationJson =
        await dio.get('${dotenv.env['API_ROOT']!}/users/location');
    List allUserLocationList = allUserLocationJson.data;

    return allUserLocationList;
  }
}
