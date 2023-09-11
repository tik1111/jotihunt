import 'package:jotihunt/handlers/handler_locations.dart';

class HandlerCircles {
  Future<List> getAllCircles(String area) async {
    List allFoxLocations =
        await LocationHandler().getLastFoxLocationByArea(area);

    return allFoxLocations;
  }
}
