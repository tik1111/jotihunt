import 'dart:async';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class HandlerCircle {
  void getCircleForEachArea() {
    //Get all fox location

    //Get the last Hunt per area

    //Add circle to list

    //return list
  }
}

class CircleForLastHuntWidget extends StatefulWidget {
  final LatLng center;
  final double initialRadius;

  const CircleForLastHuntWidget(
      {super.key, required this.center, required this.initialRadius});

  @override
  State<CircleForLastHuntWidget> createState() =>
      _CircleForLastHuntWidgetState();
}

class _CircleForLastHuntWidgetState extends State<CircleForLastHuntWidget> {
  late double radius;
  final double speedInMetersPerSecond = 1.389;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    radius = widget.initialRadius;
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        radius += speedInMetersPerSecond;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return CircleLayer(
      circles: [
        CircleMarker(
          point: widget.center,
          radius: radius,
          useRadiusInMeter: true,
          color: Colors.blue.withOpacity(0.7),
        ),
      ],
    );
  }
}
