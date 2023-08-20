import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:jotihunt/cubit/fox_location_update_cubit.dart';
import 'package:jotihunt/handlers/handler_area_status.dart';
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

class _MainMapWidgetState extends State<MainMapWidget>
    implements FoxLocationUpdateObserver {
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
  void updateState(bool shouldUpdate) {
    loadfoxLocationMarkers().then((value) {
      if (mounted) {
        setState(() {
          foxLocationMarker = value;
        });
      }
    });
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    socket.connectSocket(context);
    context.read<FoxLocationUpdateCubit>().addObserver(this);

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const DefaultBottomAppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            AreaStatusHandler().getAllAreaStatus();
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.woman),
        ),
        body: Stack(
          children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                  zoom: 9.2,
                  maxZoom: 18,
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
                  userAgentPackageName: 'com.example.app',
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
