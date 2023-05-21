import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jotihunt/widgets/bottom_app_bar.dart';
import 'package:latlong2/latlong.dart';

class JotihuntMap extends StatefulWidget {
  const JotihuntMap({super.key});

  @override
  State<JotihuntMap> createState() => _JotihuntMapState();
}

class _JotihuntMapState extends State<JotihuntMap> {
  final mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const DefaultBottomAppBar(),
      body: FlutterMap(
        options: MapOptions(
            maxZoom: 18, center: LatLng(51.949950, 6.320932), zoom: 14),
        mapController: mapController,
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(51.949950, 6.320932),
                width: 25,
                height: 25,
                builder: (context) => FlutterLogo(),
              ),
            ],
          ),
          CurrentLocationLayer(
            style: const LocationMarkerStyle(
                marker: DefaultLocationMarker(
                  child: Icon(
                    Icons.navigation,
                    color: Colors.white,
                  ),
                ),
                markerSize: Size(25, 25),
                markerDirection: MarkerDirection.heading),
          ),
        ],
      ),
    );
  }
}
