import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:jotihunt/handlers/handler_locations.dart';
import 'package:jotihunt/handlers/handler_webrequests.dart';
import 'package:latlong2/latlong.dart';

class MarkerHandler {
  Future<List<Marker>> getAllGroupMarkers() async {
    try {
      List<Marker> groupMarkerList = [];

      Dio dio = HandlerWebRequests.dio;
      Response allGroupsJson =
          await dio.get('${dotenv.env['API_ROOT']!}/groups/');

      List allGroupsList = allGroupsJson.data;

      for (var i = 0; i < allGroupsList.length; i++) {
        groupMarkerList.add(Marker(
          point: LatLng(double.parse(allGroupsList[i]['lat']),
              double.parse(allGroupsList[i]['long'])),
          builder: (context) => Transform.translate(
            offset: const Offset(-5,
                -5), //Offcenter marker by 5 px to center it with the circles
            child: IconButton(
              icon: const Icon(Icons.house,
                  color: Color.fromARGB(255, 35, 83, 156)),
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
            ),
          ),
        ));
      }

      return groupMarkerList;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return [];
    }
  }

  Future<List<Marker>> getAllUserLocations(String userId) async {
    try {
      List<Marker> userLocationMarkerList = [];
      List allUserLocationList =
          await LocationHandler().getAllCurrentHunterLocations(userId);
      Icon markerIcon = const Icon(
        Icons.directions_car,
        color: Colors.black87,
      );

      for (var i = 0; i < allUserLocationList.length; i++) {
        userLocationMarkerList.add(Marker(
            point: LatLng(double.parse(allUserLocationList[i]['lat']),
                double.parse(allUserLocationList[i]['long'])),
            builder: (context) => IconButton(
                  icon: markerIcon,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                                allUserLocationList[i]['tenant_id'].toString()),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("${allUserLocationList[i]['user_id']}"),
                                Text(
                                    "Laatste update: ${allUserLocationList[i]['created_at']}"),
                              ],
                            ),
                          );
                        });
                  },
                )));
      }

      return userLocationMarkerList;
    } catch (e) {
      return [];
    }
  }

  Future<List<Marker>> getAllOrPerAreaFoxLocations(String area) async {
    // Use the area parameter with an area to get specific data or use "" for all areas available.
    try {
      List<Marker> foxLocationMarkerList = [];
      List allFoxLocationList =
          await LocationHandler().getFoxLocationsToList(area);

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
