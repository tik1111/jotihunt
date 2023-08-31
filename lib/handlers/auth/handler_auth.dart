// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jotihunt/handlers/handler_secure_storage.dart';

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
      var response = await dio.post('${dotenv.env['API_ROOT']!}/auth/login',
          data: {'email': username, 'password': password});
      print(response);

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
      print(dioError.response);
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
          data: {'email': email, 'password': password, 'name': name});

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

  Future<bool> logout() async {
    await SecureStorage().deleteAccessToken();
    await SecureStorage().deleteRefreshToken();
    return true;
  }
}
