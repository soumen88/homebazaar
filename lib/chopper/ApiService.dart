import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:homebazaar/AppConfig.dart';
import 'package:homebazaar/chopper/Logging.dart';
import 'package:homebazaar/login/Login.dart';
import 'package:homebazaar/login/User.dart';

class ApiService{
  String currentScreen = "ApiService";
  ApiService._();
  static final instance = ApiService._();

  final baseUrl = AppConfig.BASE_URL;


  Future<List<dynamic>?> getProducts() async {
    String url = baseUrl + "/products";
    final response = await Dio().get(url);
    developer.log(currentScreen, name: "Hitting URL $url");
    if(response.statusCode == 200){
      return response.data;
    }
    else{
      developer.log(currentScreen, name: "Bad request");
    }
    return null;
  }

  Future<dynamic?> register(User user) async {
    final Dio _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ,
        connectTimeout: 5000,
        receiveTimeout: 3000,
      ),
    )..interceptors.add(Logging());

    try {
      Response response = await _dio.post(
        '/users',
        data: jsonEncode(user),
          options: Options(

            followRedirects: false,
            // will not throw errors
            validateStatus: (status) => true,
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
              }
          )
      );

      //developer.log(currentScreen, name: "Hitting URL $url");
      if(response.statusCode == 200){
        return response.data;
      }
      else{
        developer.log(currentScreen, name: "Bad request");
      }
    } catch (e) {
      developer.log(currentScreen, name:'Error creating user: $e');
    }

    return null;
  }

  Future<dynamic?> login(Login login) async {
    final Dio _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ,
        connectTimeout: 5000,
        receiveTimeout: 3000,
      ),
    )..interceptors.add(Logging());

    try {
      Response response = await _dio.post(
        '/auth/login',
        data: jsonEncode(login),
          options: Options(

            followRedirects: false,
            // will not throw errors
            validateStatus: (status) => true,
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
              }
          )
      );

      //developer.log(currentScreen, name: "Hitting URL $url");
      if(response.statusCode == 200){
        developer.log(currentScreen, name: "Response OK for login");
        return response.data;
      }
      else{
        developer.log(currentScreen, name: "Bad request");
      }
    } catch (e) {
      developer.log(currentScreen, name:'Error creating user: $e');
    }

    return null;
  }


}