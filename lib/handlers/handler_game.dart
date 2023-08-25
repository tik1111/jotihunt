import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jotihunt/handlers/handler_secure_storage.dart';

class GameHandler {
  var dio = Dio();

  Future<List<dynamic>> getAllActiveGamesFromTenant() async {
    try {
      dio.options.headers['x-access-token'] =
          await SecureStorage().getAccessToken();
      Response allGameJson = await dio.get('${dotenv.env['API_ROOT']!}/game');
      return allGameJson.data;
    } catch (e) {}

    return [];
  }

  Future<List<DropdownMenuEntry<String>>>
      getAllActiveGameInDropdownMenuEntry() async {
    List<DropdownMenuEntry<String>> newdropdownitems = [];
    try {
      List allTenantGames = await getAllActiveGamesFromTenant();

      for (var i = 0; i < allTenantGames.length; i++) {
        newdropdownitems.add(DropdownMenuEntry(
          value: allTenantGames[i]['_id'],
          label: allTenantGames[i]['_id'],
        ));
      }
      return newdropdownitems;
    } catch (e) {
      return [];
    }
  }
}
