// ignore_for_file: avoid_print
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Auth {
  var dio = Dio();

  //final streamController = StreamController<bool>.broadcast();

  loginUserWithEmailAndPassword(String username, String password) async {
    try {
      dio.options.contentType = Headers.formUrlEncodedContentType;
      //dio.options.headers['authenticationUsername'] = username;
      //dio.options.headers['authenticationPassword'] = password;
      dio.options.headers['email'] = username;
      dio.options.headers['password'] = password;

      var response = await dio.post('${dotenv.env['API_ROOT']!}/auth/login');

      print(response.data);
    } on DioError catch (dioError) {
      print(dioError.response!.data.toString());
    } catch (e) {
      print(e);
    }
  }

  registerUserWithEmailAndPassword(
      String email, String password, String firstName, String lastName) async {
    try {
      dio.options.headers['email'] = email;
      dio.options.headers['password'] = password;
      dio.options.headers['first_name'] = "tim";
      dio.options.headers['last_name'] = "van der Maas";

      var response = await dio.post('${dotenv.env['API_ROOT']!}/auth/register');
      print(response.data["_id"]);
      if (response.data["_id"] != null || response.data["_id"] != "") {
        loginUserWithEmailAndPassword(email, password);
      }

      print(response);
    } on DioError catch (dioError) {
      print(dioError.response!.data.toString());
    } catch (e) {
      print(e);
    }
  }

  logout() async {}
}
