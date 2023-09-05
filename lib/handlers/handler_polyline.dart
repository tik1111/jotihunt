import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:jotihunt/handlers/handler_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jotihunt/handlers/handler_webrequests.dart';
import 'package:latlong2/latlong.dart';

class HandlerPolyLine {
  Future<Map<String, List<dynamic>>> getPolylinesForAllAreasToList() async {
    //Get all foxLocations filted on atleast tenant_id if area is empty than get all.
    Dio dio = HandlerWebRequests.dio;
    String? gameId = await SecureStorage().getCurrentSelectedGame();

    Response allFoxLocationJson = await dio.get(
        '${dotenv.env['API_ROOT']!}/fox',
        queryParameters: {"game_id": gameId});

    List allFoxLocationList = allFoxLocationJson.data;

    //Use the result and order per area sorted by created at field

    // Sorteer de lijst op basis van de 'created_at' datum
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

  Future<List<Polyline>> getAllPolyLineToDraw() async {
    List<Polyline> polylines = [];

    Map<String, List<dynamic>> sortedAndGroupedLocations =
        await getPolylinesForAllAreasToList();

    sortedAndGroupedLocations.forEach((area, locations) {
      List<LatLng> points = [];
      for (var location in locations) {
        // Converteer de coördinaten naar LatLng objecten en voeg ze toe aan de puntenlijst
        points.add(LatLng(
            double.parse(location['lat']), double.parse(location['long'])));
      }

      // Maak een nieuwe Polyline en voeg deze toe aan de lijst
      polylines.add(
        Polyline(
          points: points,
          strokeWidth: 4.0,
          color: Colors.purple, // Kies je eigen kleur
        ),
      );
    });

    return polylines;
  }
}
