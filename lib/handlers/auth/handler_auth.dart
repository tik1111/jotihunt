// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jotihunt/handlers/handler_secure_storage.dart';
import 'package:jotihunt/handlers/handler_user.dart';
import 'package:jotihunt/handlers/handler_webrequests.dart';

enum AppState { initial, authenticated, authenticating, unauthenticated }

class Auth with ChangeNotifier {
  var dio = Dio();

  Future<bool> checkUserRefreshTokenAvailableAndValid() async {
    try {
      String? possibleRefreshToken = await SecureStorage().getRefreshToken();

      if (possibleRefreshToken != null) {
        dio.options.headers['x-refresh-token'] = possibleRefreshToken;
        var newAccesToken =
            await dio.post('${dotenv.env['API_ROOT']!}/refresh/atoken');

        if (newAccesToken.data != null &&
            newAccesToken.data != "Token not valid") {
          return true;
        }
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> loginUserWithEmailAndPassword(
      String username, String password) async {
    try {
      Response response = await dio.post(
          '${dotenv.env['API_ROOT']!}/auth/login',
          data: {'email': username, 'password': password});
      print("invalid Credentials");

      if (response.statusCode == 400) {
        print("invalid Credentials");
      }

      if (response.data['token'] != "" && response.data['refreshtoken'] != "") {
        await SecureStorage().writeAccessToken(response.data['token']);

        await SecureStorage().writeRefreshToken(response.data['refreshtoken']);
      }

      if (response.data["refreshtoken"] != null &&
          response.data['refreshtoken'] != "") {
        return true;
      }
      print(response.data);
      return false;
    } on DioException catch (dioError) {
      if (dioError.error == 400) {
        print(dioError.response);
        return false;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> registerUserWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      var response = await dio.post('${dotenv.env['API_ROOT']!}/auth/register',
          data: {
            'email': email.toLowerCase(),
            'password': password,
            'name': name
          });

      if (response.data['token'] != "" && response.data['refreshtoken'] != "") {
        await SecureStorage().writeAccessToken(response.data['token']);
        await SecureStorage().writeRefreshToken(response.data['refreshtoken']);
      }
      if (await response.data["refreshtoken"] != null) {
        print(response.data['refreshtoken']);
        return true;
      }
      return false;
    } on DioException catch (dioError) {
      print(dioError.response!.data.toString());
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> refreshAccessToken() async {
    String? currentRefreshtoken = await SecureStorage().getRefreshToken();
    print('from refresh access token');
    if (currentRefreshtoken != null && currentRefreshtoken != "") {
      dio.options.headers["x-refresh-token"] = currentRefreshtoken;
      Response newAccessToken =
          await dio.post('${dotenv.env['API_ROOT']!}/refresh/atoken');
      print(newAccessToken.data['token']);
      await SecureStorage()
          .writeAccessToken(newAccessToken.data['token'].toString());

      return true;
    }

    return false;
  }

  Future<String> getUserRoleFromWeb() async {
    String? currentKnownRoleAvailable = await SecureStorage().getUserRole();
    String userId = await HandlerUser().getUserIdFromAccessToken();
    Dio dio = HandlerWebRequests.dio;
    Response userRoleResponse = await dio
        .get('${dotenv.env['API_ROOT']!}/auth/role/${userId.toString()}');

    if (userRoleResponse.data is List) {
      Map<String, dynamic> firstObject = userRoleResponse.data[0];
      String role = firstObject['role'] ?? 'user';

      print('$role is the users role ');

      if (currentKnownRoleAvailable == role) {
        return currentKnownRoleAvailable ?? "user";
      } else {
        await SecureStorage().writeUserRole(role);
        return role;
      }
    } else {
      print('Received unexpected data from the API.');
      return currentKnownRoleAvailable ?? "user";
    }
  }

  Future<bool> logout() async {
    await SecureStorage().deleteAccessToken();
    await SecureStorage().deleteRefreshToken();
    await SecureStorage().deleteUserRole();
    await SecureStorage().deleteCurrentGame();
    await SecureStorage().deleteCurrentArea();
    await SecureStorage().deleteUserPrefCircle();
    await SecureStorage().logout();
    return true;
  }
}
