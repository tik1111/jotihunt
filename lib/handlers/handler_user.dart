import 'dart:convert';
import 'dart:js_interop';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jotihunt/handlers/handler_secure_storage.dart';
import 'package:jotihunt/handlers/handler_webrequests.dart';
import 'package:jotihunt/widgets/alertdialog_edit_user.dart';

class HandlerUser {
  final Color orangeColor = const Color.fromARGB(255, 230, 144, 35);
  final Color whiteColor = const Color.fromARGB(255, 217, 217, 219);
  Future<List<ListTile>> getAllTenantUsers() async {
    try {
      Dio dio = HandlerWebRequests.dio;
      Response allUsersJson = await dio.get('${dotenv.env['API_ROOT']!}/users');
      Response allUserRoleJson =
          await dio.get('${dotenv.env['API_ROOT']!}/auth/role');

      List allUserList = allUsersJson.data;
      List userRoles = allUserRoleJson.data;

      List<ListTile> allUserListItems = [];

      for (var i = 0; i < allUserList.length; i++) {
        String userId = allUsersJson.data[i]['_id'];
        dynamic userRole =
            userRoles.firstWhere((role) => role['user_id'] == userId);

        Map<String, String> userData = {
          'id': userId,
          'name': allUsersJson.data[i]['name'] ?? "Unknown",
          'email': allUsersJson.data[i]['email'] ?? "Unknown",
          'role': userRole['role'] ?? "Unknown",
        };

        allUserListItems.add(
          ListTile(
            enabled: true,
            leading: Icon(Icons.person, color: whiteColor),
            title: Text(allUsersJson.data[i]['name'] ?? "Unknown",
                style: TextStyle(color: whiteColor)),
            trailing: AlertdialogEditUser(userData: userData),
          ),
        );
      }
      return allUserListItems;
    } catch (e) {
      return [];
    }
  }

  Future<bool> deleteUserById(String userId) async {
    try {
      Dio dio = HandlerWebRequests.dio;

      await dio.delete('${dotenv.env['API_ROOT']!}/users/$userId', data: {});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateUserById(
      String userId, String name, String email, String role) async {
    try {
      Dio dio = HandlerWebRequests.dio;

      await dio.put('${dotenv.env['API_ROOT']!}/users/$userId',
          data: {'name': name, 'email': email},
          options: Options(
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          ));

      await dio.put('${dotenv.env['API_ROOT']!}/auth/role/$userId',
          data: {'role': role},
          options: Options(
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          ));

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> getUserIdFromAccessToken() async {
    String? token = await SecureStorage().getAccessToken() ?? "";

    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = parts[1];
    final normalizedPayload = base64Url.normalize(payload);
    final resp = utf8.decode(base64Url.decode(normalizedPayload));
    final payloadMap = json.decode(resp);
    print(payloadMap['user_id']);
    return payloadMap['user_id'];
  }
}
