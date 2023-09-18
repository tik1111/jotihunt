import 'package:dio/dio.dart';
import 'package:jotihunt/handlers/auth/handler_auth.dart';
import 'package:jotihunt/handlers/handler_secure_storage.dart';

class HandlerWebRequests {
  static final Dio dio = Dio();

  static void init() async {
    int retryCount = 0;
    dio.interceptors.clear();
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      options.headers['x-access-token'] =
          await SecureStorage().getAccessToken();
      return handler.next(options);
    }, onError: (DioException e, ErrorInterceptorHandler handler) async {
      if (e.response?.statusCode != 403) {
        if (e.response?.statusCode == 401 && retryCount < 4) {
          retryCount++;
          final newAccessToken = await Auth().refreshAccessToken();

          e.requestOptions.headers['x-access-token'] = newAccessToken;

          Options options = Options(
            method: e.requestOptions.method,
            headers: e.requestOptions.headers,
            // Hier kun je aanvullende velden overnemen indien nodig
          );

          try {
            var response = await dio.request(
              e.requestOptions.path,
              cancelToken: e.requestOptions.cancelToken,
              data: e.requestOptions.data,
              onReceiveProgress: e.requestOptions.onReceiveProgress,
              onSendProgress: e.requestOptions.onSendProgress,
              queryParameters: e.requestOptions.queryParameters,
              options: options,
            );
            return handler.resolve(response);
          } catch (error) {
            return handler.next(e);
          }
        }
      }
    }));
  }
}
