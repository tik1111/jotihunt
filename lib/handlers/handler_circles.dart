import 'package:flutter_map/flutter_map.dart';
import 'package:jotihunt/handlers/handler_locations.dart';
import 'package:latlong2/latlong.dart';

class HandlerCircles {
  Future<List> getAllCircles(String area) async {
    List allFoxLocations =
        await LocationHandler().getLastFoxLocationByArea(area);

    return allFoxLocations;
  }
}
