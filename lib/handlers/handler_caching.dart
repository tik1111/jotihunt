import 'package:flutter/foundation.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart'
    if (dart.library.html) 'dummy.dart'
    if (dart.library.io) 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';

class HandlerMapCaching {
  void init() async {
    if (kIsWeb) {
//
    } else {
      await FlutterMapTileCaching.initialise();
      // ignore: non_constant_identifier_names, await_only_futures
      var FM = await FMTC.instance('mapStore');
      FM.manage.createAsync();
    }
  }
}
