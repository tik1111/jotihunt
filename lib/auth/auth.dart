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

  logout() async {}
}
