import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jotihunt/handlers/handler_secure_storage.dart';

import 'package:jotihunt/handlers/handler_webrequests.dart';

class GameHandler {
  Future<List<dynamic>> getAllActiveGamesFromTenant() async {
    var dio = HandlerWebRequests.dio;
    Response allGameJson = await dio.get('${dotenv.env['API_ROOT']!}/game');

    return allGameJson.data;
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

  Future<List<ListTile>> getAllActiveGameListTile() async {
    List<ListTile> listTiles = [];
    String? currentGameId = await SecureStorage().getCurrentSelectedGame();

    try {
      List allTenantGames = await getAllActiveGamesFromTenant();

      for (var i = 0; i < allTenantGames.length; i++) {
        bool isSelected = allTenantGames[i]['_id'] == currentGameId;

        listTiles.add(ListTile(
          title: Text(allTenantGames[i]['_id']),
          onTap: () async {
            await SecureStorage().writeCurrentGame(allTenantGames[i]['_id']);
            // Refresh the list to show the new selected item.
          },
          trailing:
              isSelected ? const Icon(Icons.check, color: Colors.green) : null,
        ));
      }

      if (currentGameId == null || currentGameId.isEmpty) {
        listTiles.add(const ListTile(
          title: Text('Geen game geselecteerd'),
        ));
      }
      return listTiles;
    } catch (e) {
      return [];
    }
  }

  Future<bool> createNewGame(String gameName) async {
    var dio = HandlerWebRequests.dio;
    await dio.post('${dotenv.env['API_ROOT']!}/game');

    return true;
  }
}
