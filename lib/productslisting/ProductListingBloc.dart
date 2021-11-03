import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebazaar/chopper/ApiService.dart';
import 'package:homebazaar/productslisting/Products.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
String currentScreen = "ProductListingBloc";

class ProductListingNotifierBloc extends StateNotifier<AsyncValue<List<Products>?>>{

  ProductListingNotifierBloc() : super(AsyncData(null)){
    getProductsFromServer();
  }

  void getProductsFromServer() async{
    final quoteService = ApiService.instance;
    final response = await quoteService.getProducts();
    String currentScreen = "ProductListingBloc";
    List<Products> products = [];
    if (response != null && response.isNotEmpty) {
      // If the call to the server was successful (returns OK), parse the JSON.
      developer.log(currentScreen, name: "Reponse was successful");
      for(var singleProduct in response){
        var current = Products.fromJson(singleProduct);
        products.add(current);
      }

      state = AsyncData(products) ;
    }
    else{
      developer.log(currentScreen, name: "Reponse was not successful");
    }
  }

}

