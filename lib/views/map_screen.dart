import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:jotihunt/handlers/handler_markers.dart';
import 'package:jotihunt/widgets/bottomappbar_hunter_interface.dart';
import 'package:jotihunt/widgets/alertdialog_hunt_code.dart';
import 'package:latlong2/latlong.dart';

class MainMapWidget extends StatefulWidget {
  const MainMapWidget({super.key});

  @override
  State<MainMapWidget> createState() => _MainMapWidgetState();
}

class _MainMapWidgetState extends State<MainMapWidget> {
  final mapController = MapController();
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
  void initState() {
    super.initState();
    //LocationHandler().verifyLocationPermissionAndServiceAcitve();
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
            loadfoxLocationMarkers().then((value) {
              setState(() {
                foxLocationMarker = value;
              });
            });
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.woman),
        ),
        body: FlutterMap(
          mapController: mapController,
          options: MapOptions(
              zoom: 9.2,
              maxZoom: 18,
              center: const LatLng(51.94915, 6.32091),
              onTap: (tapPosition, point) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return HuntCodeAlertDialogWidget(
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
        ));
  }
}
