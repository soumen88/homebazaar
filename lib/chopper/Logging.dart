import 'package:dio/dio.dart';
import 'dart:developer' as developer;

class Logging extends Interceptor {
  String currentScreen = "Logging";
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    developer.log(currentScreen, name: 'REQUEST[${options.method}] => PATH: ${options.path} , data = ${options.data}' );
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    developer.log(currentScreen, name: 'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    return super.onError(err, handler);
  }
}