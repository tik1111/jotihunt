import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jotihunt/handlers/handler_secure_storage.dart';

class AreaStatusHandler {
  var dio = Dio();

  Future<List<DropdownMenuEntry<String>>> getAllAreaStatus() async {
    try {
      dio.options.headers['x-access-token'] =
          await SecureStorage().getAccessToken();
      Response allGroupsJson =
          await dio.get('${dotenv.env['API_ROOT']!}/areastatus');

      List allAreaStatusList = allGroupsJson.data;

      List<DropdownMenuEntry<String>> newdropdownitems = [];

      for (var i = 0; i < allAreaStatusList.length; i++) {
        Icon thisicon;
        switch (allAreaStatusList[i]['status']) {
          case 'red':
            thisicon = const Icon(
              Icons.circle,
              color: Colors.red,
            );
            break;
          case 'orange':
            thisicon = const Icon(
              Icons.circle,
              color: Colors.orange,
            );
            break;
          case 'green':
            thisicon = const Icon(
              Icons.circle,
              color: Colors.green,
            );
            break;
          default:
            thisicon = const Icon(
              Icons.circle,
              color: Colors.red,
            );
            break;
        }

        newdropdownitems.add(DropdownMenuEntry(
            value: allAreaStatusList[i]['status'],
            label: allAreaStatusList[i]['name'],
            trailingIcon: thisicon));
      }
      return newdropdownitems;
    } on DioException {
      return [];
    } catch (e) {
      return [];
    }
  }
}