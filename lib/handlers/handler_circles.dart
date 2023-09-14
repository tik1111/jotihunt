import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:jotihunt/handlers/handler_locations.dart';
import 'package:jotihunt/handlers/handler_webrequests.dart';
import 'package:latlong2/latlong.dart';

class HandlerCircles {
  Future<List> getAllCircles(String area) async {
    List allFoxLocations =
        await LocationHandler().getLastFoxLocationByArea(area);

    return allFoxLocations;
  }

  Future<List<CircleMarker>> getAllGroupCircle() async {
    List<CircleMarker> groupList = [];

    Dio dio = HandlerWebRequests.dio;
    Response allGroupsJson =
        await dio.get('${dotenv.env['API_ROOT']!}/groups/');

    List allGroupsList = allGroupsJson.data;

    for (var i = 0; i < allGroupsList.length; i++) {
      groupList.add(
        CircleMarker(
            point: LatLng(double.parse(allGroupsList[i]['lat']),
                double.parse(allGroupsList[i]['long'])),
            useRadiusInMeter: true,
            borderStrokeWidth: 1,
            borderColor: Colors.black54,
            color: Colors.white54,
            radius: 500),
      );
      groupList.add(
        CircleMarker(
            point: LatLng(double.parse(allGroupsList[i]['lat']),
                double.parse(allGroupsList[i]['long'])),
            useRadiusInMeter: true,
            borderStrokeWidth: 1,
            borderColor: Colors.grey,
            color: Color.fromARGB(0, 164, 164, 164),
            radius: 400),
      );
    }

    return groupList;
  }
}
