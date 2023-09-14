import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:jotihunt/handlers/handler_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jotihunt/handlers/handler_webrequests.dart';
import 'package:latlong2/latlong.dart';

class HandlerPolyLine {
  Future<Map<String, List<dynamic>>> getPolylinesForAllAreasToList(
      String area) async {
    //Get all foxLocations filted on atleast tenant_id if area is empty than get all.
    Dio dio = HandlerWebRequests.dio;
    String? gameId = await SecureStorage().getCurrentSelectedGame();

    if (area.isEmpty) {
      Response allFoxLocationJson = await dio.get(
          '${dotenv.env['API_ROOT']!}/fox',
          queryParameters: {"game_id": gameId});
      List allFoxLocationList = allFoxLocationJson.data;
      allFoxLocationList.sort((a, b) => DateTime.parse(a['created_at'])
          .compareTo(DateTime.parse(b['created_at'])));

      Map<String, List<dynamic>> groupedByArea = {};
      for (var location in allFoxLocationList) {
        String area = location['area'] ?? 'Unknown';
        if (groupedByArea.containsKey(area)) {
          groupedByArea[area]!.add(location);
        } else {
          groupedByArea[area] = [location];
        }
      }

      return groupedByArea;
    } else {
      Response allFoxLocationJson = await dio.get(
          '${dotenv.env['API_ROOT']!}/fox',
          queryParameters: {"game_id": gameId, "area": area});
      List allFoxLocationList = allFoxLocationJson.data;
      allFoxLocationList.sort((a, b) => DateTime.parse(a['created_at'])
          .compareTo(DateTime.parse(b['created_at'])));

      // Print de gesorteerde lijst om te controleren
      Map<String, List<dynamic>> groupedByArea = {};
      for (var location in allFoxLocationList) {
        String area = location['area'] ?? 'Unknown';
        if (groupedByArea.containsKey(area)) {
          groupedByArea[area]!.add(location);
        } else {
          groupedByArea[area] = [location];
        }
      }

      return groupedByArea;
    }
  }

  Future<List<Polyline>> getAllPolyLineToDraw(String area) async {
    List<Polyline> polylines = [];

    Map<String, List<dynamic>> sortedAndGroupedLocations;

    if (area.isEmpty) {
      sortedAndGroupedLocations = await getPolylinesForAllAreasToList("");
    } else {
      sortedAndGroupedLocations = await getPolylinesForAllAreasToList(area);
    }

    sortedAndGroupedLocations.forEach((area, locations) {
      List<LatLng> points = [];
      for (var location in locations) {
        points.add(LatLng(
            double.parse(location['lat']), double.parse(location['long'])));
      }

      polylines.add(
        Polyline(
          points: points,
          strokeWidth: 4.0,
          color: const Color.fromARGB(255, 181, 116, 193),
        ),
      );
    });

    return polylines;
  }
}
