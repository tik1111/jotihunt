import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:jotihunt/handlers/MarkerHandler.dart';
import 'package:jotihunt/widgets/bottom_app_bar.dart';
import 'package:latlong2/latlong.dart';

class MainMapWidget extends StatefulWidget {
  const MainMapWidget({super.key});

  @override
  State<MainMapWidget> createState() => _MainMapWidgetState();
}

class _MainMapWidgetState extends State<MainMapWidget> {
  final mapController = MapController();
  List<Marker> groupMarkers = [];

  Future<List<Marker>> loadGroupMarkers() async {
    return MarkerHandler().getAllGroupMarkers();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadGroupMarkers().then((value) {
      setState(() {
        groupMarkers = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const DefaultBottomAppBar(),
        body: FlutterMap(
          mapController: mapController,
          options: MapOptions(zoom: 9.2, maxZoom: 18),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            MarkerLayer(markers: groupMarkers)
          ],
        ));
  }
}
