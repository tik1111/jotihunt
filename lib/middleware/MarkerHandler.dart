import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:jotihunt/middleware/secure_storage.dart';
import 'package:latlong2/latlong.dart';

class MarkerHandler {
  var dio = Dio();

  Future<List<Marker>> getAllGroupMarkers() async {
    try {
      List<Marker> groupMarkerList = [];

      dio.options.headers['x-access-token'] =
          await SecureStorage().getAccessToken();
      Response allGroupsJson =
          await dio.get('${dotenv.env['API_ROOT']!}/groups/');

      List allGroupsList = allGroupsJson.data;

      for (var i = 0; i < allGroupsList.length; i++) {
        groupMarkerList.add(Marker(
            point: LatLng(double.parse(allGroupsList[i]['lat']),
                double.parse(allGroupsList[i]['long'])),
            builder: (context) => const FlutterLogo()));
      }
      print(groupMarkerList.toString());

      return groupMarkerList;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
