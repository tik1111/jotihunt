// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
// ignore: unused_import
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart'
    if (dart.library.html) '../handlers/dummy.dart'
    if (dart.library.io) 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:jotihunt/Cubit/fox_timer_cubit.dart';
import 'package:jotihunt/Cubit/stream_provider.dart';
import 'package:jotihunt/handlers/handler_circles.dart';
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
import 'package:location/location.dart';

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
  List<Marker> userLocationMarkers = [];
  List<Marker> foxLocationMarkers = [];
  List<Polyline> foxLocationPolylines = [];

  Location location = Location();
  late LocationData currentLocation;

  DateTime timeToHunt = DateTime.parse("2023-09-04T12:14:07.649+00:00");
  StreamSubscription<String>? deelareaUpdateSubscription;
  StreamSubscription<String>? userLocationUpdateSubscription;
  StreamSubscription<LocationData>? locationUpdate;

  final _formKey = GlobalKey<FormState>();
  final huntCodeFormController = TextEditingController();

  LatLng center = const LatLng(51.94916, 6.32094);
  double initialRadius = 100;

  _initLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    location.changeSettings(
        distanceFilter: 250, accuracy: LocationAccuracy.high, interval: 30000);
    currentLocation = await location.getLocation();

    await LocationHandler().postNewHunterLocation(currentLocation);

    locationUpdate =
        location.onLocationChanged.listen((LocationData updatedLocation) async {
      await LocationHandler().postNewHunterLocation(updatedLocation);
      if (mounted) {
        setState(() {
          currentLocation = updatedLocation;
        });
      }
    });
  }

  void updateHuntTime() async {
    DateTime currentAreaHuntTime = await LocationHandler()
        .getLastLocationByAreaToCreatedAt(
            await SecureStorage().getCurrentSelectedArea() ?? "Alpha");
    if (currentAreaHuntTime == DateTime.now()) {
      if (mounted) {
        context
            .read<HuntTimeCubit>()
            .updateHuntTime(DateTime.parse("2023-09-04T12:14:07.649+00:00"));
      }
    } else {
      if (mounted) {
        context.read<HuntTimeCubit>().updateHuntTime(currentAreaHuntTime);
      }
    }
  }

  Future<bool> isGameSelectedFromStorage() async {
    String? currentGame = await SecureStorage().getCurrentSelectedGame();
    if (currentGame != null && currentGame != "") {
      return true;
    } else {
      bool currentGame = await getAllGamesFromTenantPickFirst();
      if (currentGame) {
        return true;
      }
    }
    return false;
  }

  Future<bool> getAllGamesFromTenantPickFirst() async {
    List? allGames = await GameHandler().getAllActiveGamesFromTenant();

    if (allGames.isNotEmpty) {
      await SecureStorage().writeCurrentGame(allGames[0]['_id'].toString());
      return true;
    }
    return false;
  }

  Future<List<Marker>> loadGroupMarkers() async {
    return MarkerHandler().getAllGroupMarkers();
  }

  Future<List<Marker>> loadfoxLocationMarkers(String area) async {
    return MarkerHandler().getAllOrPerAreaFoxLocations(area);
  }

  Future<List<Marker>> loadUserLocationMarkers(String userId) async {
    return MarkerHandler().getAllUserLocations(userId);
  }

  Future<List<Polyline>> loadPolylineFromFoxLocations(String area) async {
    return HandlerPolyLine().getAllPolyLineToDraw(area);
  }

  Future<List> loadCircleMarkersFromLastFoxLocations(String area) async {
    return HandlerCircles().getAllCircles(area);
  }

  @override
  void dispose() {
    mapController.dispose();
    deelareaUpdateSubscription?.cancel();
    userLocationUpdateSubscription?.cancel();
    locationUpdate?.cancel();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _initLocation();
    isGameSelectedFromStorage().then((value) {
      if (value) {
        if (mounted) {
          setState(() {
            isGameSelected = value;
          });
        }
        updateHuntTime();
        loadGroupMarkers().then((value) {
          if (mounted) {
            setState(() {
              groupMarkers = value;
            });
          }
        });
        loadfoxLocationMarkers("").then((value) {
          if (mounted) {
            setState(() {
              foxLocationMarkers = value;
            });
          }
        });
        loadPolylineFromFoxLocations("").then((value) {
          if (mounted) {
            setState(() {
              foxLocationPolylines = value;
            });
          }
        });
        loadUserLocationMarkers("").then((value) {
          if (mounted) {
            setState(() {
              userLocationMarkers = value;
            });
          }
        });

        userLocationUpdateSubscription =
            userLocationUpdateStream.getResponse.listen(
          (userId) {
            loadUserLocationMarkers("").then((value) {
              if (mounted) {
                setState(() {
                  userLocationMarkers = value;
                });
              }
            });
          },
        );

        deelareaUpdateSubscription = foxLocationUpdateSingleAreaStream
            .getResponse
            .listen((deelgebiedUpdate) {
          loadfoxLocationMarkers(deelgebiedUpdate).then((newMarkers) {
            updateHuntTime();
            for (var newMarker in newMarkers) {
              int index = foxLocationMarkers.indexWhere(
                  (oldMarker) => oldMarker.point == newMarker.point);

              if (index != -1) {
                foxLocationMarkers[index] = newMarker;
              } else {
                foxLocationMarkers.add(newMarker);
              }
            }
            if (mounted) {
              setState(() {});
            }
          });

          loadPolylineFromFoxLocations(deelgebiedUpdate).then((newPolyLines) {
            for (var newPloyline in newPolyLines) {
              int index = foxLocationMarkers.indexWhere(
                  // ignore: unrelated_type_equality_checks
                  (oldMarker) => oldMarker.point == newPloyline.points);

              if (index != -1) {
                foxLocationPolylines[index] = newPloyline;
              } else {
                foxLocationPolylines.add(newPloyline);
              }
            }
            if (mounted) {
              setState(() {});
            }
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HuntTimeCubit, DateTime>(
      builder: (context, state) {
        return Scaffold(
            bottomNavigationBar: const DefaultBottomAppBar(),

            //Debug button ;-)
            //floatingActionButton: FloatingActionButton(
            //  onPressed: () async {
            //    await SecureStorage().writeAccessToken("bla");
            //    GameHandler().getAllActiveGamesFromTenant();
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
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'nl.jotihunters.jotihunt',
                      //tileProvider: FMTC.instance('mapStore').getTileProvider(),
                    ),
                    PolylineLayer(
                      polylines: foxLocationPolylines,
                    ),
                    MarkerLayer(markers: foxLocationMarkers),
                    MarkerLayer(markers: userLocationMarkers),
                    MarkerLayer(markers: groupMarkers),
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
                            : [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Container(
                                        color: Colors.white,
                                        padding: const EdgeInsets.all(16.0),
                                        child: const Text(
                                          "Er is geen game geselecteerd of beschikbaar",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
