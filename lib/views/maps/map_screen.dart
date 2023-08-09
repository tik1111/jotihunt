import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:jotihunt/handlers/LocationHandler.dart';
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
  final _formKey = GlobalKey<FormState>();
  final huntCodeFormController = TextEditingController();

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
    super.initState();
    loadGroupMarkers().then((value) {
      setState(() {
        groupMarkers = value;
      });
    });
  }

  bool huntOrSpot = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const DefaultBottomAppBar(),
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
                      return AlertDialog(
                        content: Stack(
                          clipBehavior: Clip.none,
                          children: <Widget>[
                            Positioned(
                              right: -40.0,
                              top: -40.0,
                              child: InkResponse(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      decoration:
                                          InputDecoration(hintText: "Huntcode"),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Switch(

                                        // This bool value toggles the switch.
                                        value: huntOrSpot,
                                        activeColor: Colors.blue,
                                        onChanged: (value) {
                                          // This is called when the user toggles the switch.
                                          setState(() {
                                            print("yes");
                                            huntOrSpot = value;
                                          });
                                        }),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      child: Text("Submit"),
                                      onPressed: () {
                                        LocationHandler().addHunt(point);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              }),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            MarkerLayer(markers: groupMarkers),
          ],
        ));
  }
}
