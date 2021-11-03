import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:homebazaar/AppConfig.dart';

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
}