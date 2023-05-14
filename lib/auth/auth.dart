// ignore_for_file: avoid_print
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jotihunt/middleware/secure_storage.dart';

enum AppState { initial, authenticated, authenticating, unauthenticated }

class Auth with ChangeNotifier {
  var dio = Dio();

  Future<bool> loginUserWithEmailAndPassword(
      String username, String password) async {
    try {
      dio.options.contentType = Headers.formUrlEncodedContentType;
      dio.options.headers['email'] = username;
      dio.options.headers['password'] = password;

      var response = await dio.post('${dotenv.env['API_ROOT']!}/auth/login');

      if (response.data['token'] != "" && response.data['refreshtoken'] != "") {
        SecureStorage().writeAccessToken(response.data['token']);
        SecureStorage().writeRefreshToken(response.data['refreshtoken']);
      }

      if (response.data["refreshtoken"] != null &&
          response.data['refreshtoken'] != "") {
        print(response.data);
        return true;
      }
      print(response.data);
      return false;
    } on DioError catch (dioError) {
      print(dioError.response!.data.toString());
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
      dio.options.headers['email'] = email;
      dio.options.headers['password'] = password;
      dio.options.headers['name'] = name;

      var response = await dio.post('${dotenv.env['API_ROOT']!}/auth/register');

      if (response.data['token'] != "" && response.data['refreshtoken'] != "") {
        SecureStorage().writeAccessToken(response.data['token']);
        SecureStorage().writeRefreshToken(response.data['refreshtoken']);
      }
      if (await response.data["refreshtoken"] != null) {
        print(response.data['refreshtoken']);
        return true;
      }
      return false;
    } on DioError catch (dioError) {
      print(dioError.response!.data.toString());
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> logout() async {
    return true;
  }
}
