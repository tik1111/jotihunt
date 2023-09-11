import 'package:flutter/foundation.dart';
//import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart'
//  if (dart.library.html) 'package:flutter/foundation.dart';

class HandlerMapCaching {
  void init() async {
    if (kIsWeb) {
      print(true);
//
    } else {
      //await FlutterMapTileCaching.initialise();
      //await FMTC.instance('mapStore').manage.createAsync();
      print(false);
    }
  }
}
