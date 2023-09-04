import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:jotihunt/handlers/handler_locations.dart';
import 'package:jotihunt/handlers/handler_secure_storage.dart';
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
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Deelgebied: ${allGroupsList[i]['area']}"),
                                Text(
                                    "Adres: ${allGroupsList[i]['street']} ${allGroupsList[i]['housenumber']}")
                              ],
                            ),
                          );
                        });
                  },
                )));
      }

      return groupMarkerList;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return [];
    }
  }

  Future<List<Marker>> getAllUserLocations() async {
    return [];
  }

  Future<List<Marker>> getAllFoxLocations() async {
    try {
      List<Marker> foxLocationMarkerList = [];
      List allFoxLocationList = await LocationHandler().getFoxLocationsToList();

      Icon markerIcon = const Icon(
        Icons.girl_rounded,
        color: Colors.redAccent,
      );

      for (var i = 0; i < allFoxLocationList.length; i++) {
        switch (allFoxLocationList[i]['type']) {
          case 'hunt':
            markerIcon = const Icon(
              Icons.verified,
              color: Colors.redAccent,
            );
            break;
          case 'spot':
            markerIcon = const Icon(
              Icons.remove_red_eye,
              color: Colors.amber,
            );
            break;
          case 'hint':
            markerIcon = const Icon(
              Icons.help_rounded,
              color: Colors.purple,
            );
            break;
          default:
            markerIcon = const Icon(
              Icons.help_rounded,
              color: Colors.redAccent,
            );
            break;
        }
        Icon currentIcon = markerIcon;
        foxLocationMarkerList.add(Marker(
            point: LatLng(double.parse(allFoxLocationList[i]['lat']),
                double.parse(allFoxLocationList[i]['long'])),
            builder: (context) => IconButton(
                  icon: currentIcon,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title:
                                Text(allFoxLocationList[i]['type'].toString()),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                    "Deelgebied: ${allFoxLocationList[i]['area']}"),
                              ],
                            ),
                          );
                        });
                  },
                )));
      }

      return foxLocationMarkerList;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return [];
    }
  }
}
