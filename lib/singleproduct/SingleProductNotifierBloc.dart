import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebazaar/chopper/ApiService.dart';
import 'package:homebazaar/productslisting/Products.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

String currentScreen = "SingleProductNotifierBloc";

class SingleProductNotifierBloc extends StateNotifier<AsyncValue<Products?>>{

  SingleProductNotifierBloc() : super(AsyncData(null));

  void getProductDetails(int productId) async{
    developer.log(currentScreen, name : "Selected product id from server ${productId}");
    state = AsyncLoading();
    final quoteService = ApiService.instance;
    final response = await quoteService.getProducts();
    List<Products> products = [];
    if (response != null && response.isNotEmpty) {
      // If the call to the server was successful (returns OK), parse the JSON.
      developer.log(currentScreen, name: "Reponse was successful");
      for(var singleProduct in response){
        var current = Products.fromJson(singleProduct);
        products.add(current);
      }

      state = AsyncData(products.first) ;
    }
    else{
      developer.log(currentScreen, name: "Reponse was not successful");
    }
  }



}