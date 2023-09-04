import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:jotihunt/Cubit/fox_timer_cubit.dart';
import 'package:jotihunt/Cubit/stream_provider.dart';
import 'package:jotihunt/handlers/handler_game.dart';
import 'package:jotihunt/handlers/handler_locations.dart';
import 'package:jotihunt/handlers/handler_markers.dart';
import 'package:jotihunt/handlers/handler_polyline.dart';
import 'package:jotihunt/handlers/handler_secure_storage.dart';
import 'package:jotihunt/handlers/handler_streamsocket.dart';
import 'package:jotihunt/widgets/alertdiolog_hunt_or_spot.dart';
import 'package:jotihunt/widgets/bottomappbar_hunter_interface.dart';
import 'package:jotihunt/widgets/dropdown_area_status.dart';
import 'package:jotihunt/widgets/timer_time_to_hunt.dart';
import 'package:latlong2/latlong.dart';

class MainMapWidget extends StatefulWidget {
  const MainMapWidget({super.key});

  @override
  State<MainMapWidget> createState() => _MainMapWidgetState();
}

class _MainMapWidgetState extends State<MainMapWidget> {
  final mapController = MapController();
  final socket = SocketConnection();

  bool isGameSelected = false;
  List<Marker> groupMarkers = [];
  List<Marker> foxLocationMarker = [];
  List<Polyline> foxLocationPolyline = [];
  DateTime timeToHunt = DateTime.parse("2023-09-04T12:14:07.649+00:00");

  final _formKey = GlobalKey<FormState>();
  final huntCodeFormController = TextEditingController();

  void updateHuntTime() async {
    // ignore: use_build_context_synchronously
    context.read<HuntTimeCubit>().updateHuntTime(await LocationHandler()
        .getLastLocationByArea(
            await SecureStorage().getCurrentSelectedArea() ?? "Alpha"));
  }

  Future<bool> isGameSelectedFromStorage() async {
    String? currentGame = await SecureStorage().getCurrentSelectedGame();
    if (currentGame != null && currentGame != "") {
      return true;
    }
    return false;
  }

  Future<List<Marker>> loadGroupMarkers() async {
    return MarkerHandler().getAllGroupMarkers();
  }

  Future<List<Marker>> loadfoxLocationMarkers() async {
    return MarkerHandler().getAllFoxLocations();
  }

  Future<List<Polyline>> loadPolylineFromFoxLocations() async {
    return HandlerPolyLine().getAllPolyLineToDraw();
  }

  @override
  void dispose() {
    mapController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    isGameSelectedFromStorage().then((value) {
      if (value) {
        setState(() {
          isGameSelected = value;
        });
        updateHuntTime();
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
        loadPolylineFromFoxLocations().then((value) {
          setState(() {
            foxLocationPolyline = value;
          });
        });

        //updateHuntTime();

        foxLocationUpdateStream.getResponse.listen((event) async {
          if (mounted) {
            setState(() {
              loadfoxLocationMarkers().then((value) {
                setState(() {
                  foxLocationMarker = value;
                });
              });
              loadPolylineFromFoxLocations().then((value) {
                setState(() {
                  updateHuntTime();
                  foxLocationPolyline = value;
                });
              });
            });
          }
        });
      }
    });

    if (isGameSelected) {}
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HuntTimeCubit, DateTime>(
      builder: (context, state) {
        return Scaffold(
            bottomNavigationBar: const DefaultBottomAppBar(),

            //Debug buttom ;-)
            //floatingActionButton: FloatingActionButton(
            //  onPressed: () {
            //    LocationHandler().getLastLocationByArea('Delta');
            //  },
            //  backgroundColor: Colors.green,
            //  child: const Icon(Icons.line_axis),
            //),
            body: Stack(
              children: [
                FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                      zoom: 14,
                      minZoom: 10,
                      maxZoom: 19,
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
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'nl.jotihunters.jotihunt',
                    ),
                    MarkerLayer(markers: groupMarkers),
                    PolylineLayer(
                      polylines: foxLocationPolyline,
                    ),
                    MarkerLayer(markers: foxLocationMarker),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 40, 8, 8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // ignore: prefer_const_constructors
                        children: isGameSelected == true
                            ? [
                                BlocBuilder<HuntTimeCubit, DateTime>(
                                  builder: (context, huntTime) {
                                    if (huntTime == DateTime.utc(2000, 1, 1)) {
                                      return const Text(
                                          "Tijd tot hunt berekenen ...");
                                    } else {
                                      return TimerTimeToNextHunt(
                                          createdAt: huntTime);
                                    }
                                  },
                                ),
                                const DropdownMenuAreaStatus()
                              ]
                            : [],
                      )
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }
}
