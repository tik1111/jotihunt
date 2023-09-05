import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jotihunt/handlers/handler_webrequests.dart';

class AreaStatusHandler {
  Future<List<dynamic>> getAllAreaStatusString() async {
    try {
      Dio dio = HandlerWebRequests.dio;
      Response allGroupsJson =
          await dio.get('${dotenv.env['API_ROOT']!}/areastatus');

      List allAreaStatusList = allGroupsJson.data;
      return allAreaStatusList;
    } catch (e) {
      return [];
    }
  }

  Future<List<DropdownMenuEntry<String>>>
      getAllAreaStatusDropDownMenuEntry() async {
    try {
      Dio dio = HandlerWebRequests.dio;
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
            value: allAreaStatusList[i]['name'],
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
