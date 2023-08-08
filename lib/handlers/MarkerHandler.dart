import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:jotihunt/handlers/secure_storage.dart';
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
            builder: (context) => IconButton(
                  icon: const Icon(Icons.house, color: Colors.green),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(allGroupsList[i]['name'].toString()),
                            content: Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                      "Deelgebied: ${allGroupsList[i]['area']}"),
                                  Text(
                                      "Adres: ${allGroupsList[i]['street']} ${allGroupsList[i]['housenumber']}")
                                ],
                              ),
                            ),
                          );
                        });
                  },
                )));
      }

      return groupMarkerList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Marker>> getAllUserLocations() async {
    return [];
  }
}
