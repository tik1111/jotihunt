import 'dart:async';

import 'package:flutter_map/flutter_map.dart';

class Manage {
  Future<void> createAsync() async {
    // Dummy logic
  }
}

class FlutterMapTileCaching {
  final Manage manage = Manage();
  final TileProvider t = FileTileProvider();

  TileProvider getTileProvider() {
    // Dummy logic
    return t;
  }

  static Future<FlutterMapTileCaching> initialise() async {
    // Dummy logic
    return FlutterMapTileCaching();
  }

  static Future<FlutterMapTileCaching> instance(String mapStore) async {
    // Dummy logic
    return FlutterMapTileCaching();
  }
}

typedef FMTC = FlutterMapTileCaching;
