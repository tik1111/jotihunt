import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:jotihunt/cubitAndStream/stream_provider.dart';
import 'package:jotihunt/handlers/handler_area_status.dart';
import 'package:jotihunt/handlers/handler_game.dart';
import 'package:jotihunt/handlers/handler_markers.dart';
import 'package:jotihunt/handlers/handler_streamsocket.dart';
import 'package:jotihunt/widgets/alertdiolog_hunt_or_spot.dart';
import 'package:jotihunt/widgets/bottomappbar_hunter_interface.dart';

import 'package:jotihunt/widgets/dropdown_area_status.dart';
import 'package:latlong2/latlong.dart';

class MainMapWidget extends StatefulWidget {
  const MainMapWidget({super.key});

  @override
  State<MainMapWidget> createState() => _MainMapWidgetState();
}

class _MainMapWidgetState extends State<MainMapWidget> {
  final mapController = MapController();
  final socket = SocketConnection();

  List<Marker> groupMarkers = [];
  List<Marker> foxLocationMarker = [];

  final _formKey = GlobalKey<FormState>();
  final huntCodeFormController = TextEditingController();

  Future<List<Marker>> loadGroupMarkers() async {
    return MarkerHandler().getAllGroupMarkers();
  }

  Future<List<Marker>> loadfoxLocationMarkers() async {
    return MarkerHandler().getAllFoxLocations();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    loadGroupMarkers().then((value) {
      setState(() {
        groupMarkers = value;
      });
    });
    loadfoxLocationMarkers().then((value) {
      setState(() {
        foxLocationMarker = value;
      });
    });

    foxLocationUpdateStream.getResponse.listen((event) {
      if (mounted) {
        setState(() {
          loadfoxLocationMarkers().then((value) {
            setState(() {
              print("new socket event in listner");
              foxLocationMarker = value;
            });
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const DefaultBottomAppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            GameHandler().getAllActiveGamesFromTenant();
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.woman),
        ),
        body: Stack(
          children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                  zoom: 14,
                  minZoom: 10,
                  maxZoom: 16,
                  center: const LatLng(51.94915, 6.32091),
                  onTap: (tapPosition, point) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return HuntOrSpotAlertDialog(
                            formKey: _formKey,
                            point: point,
                          );
                        });
                  }),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'nl.jotihunters.jotihunt',
                ),
                //CurrentLocationLayer(),
                MarkerLayer(markers: groupMarkers),
                MarkerLayer(markers: foxLocationMarker),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [DropdownMenuAreaStatus()],
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
