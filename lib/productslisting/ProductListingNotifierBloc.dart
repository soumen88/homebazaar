import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebazaar/chopper/ApiService.dart';
import 'package:homebazaar/productslisting/Products.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
String currentScreen = "ProductListingBloc";

List<Products> receivedProducts = [];
List<Products> get receivedProductsFromServer => receivedProducts;

class ProductListingNotifierBloc extends StateNotifier<AsyncValue<List<Products>?>>{
  StreamController<String>? _streamController;
  StreamController<String> get streamController => _streamController!;

  ProductListingNotifierBloc() : super(AsyncData(null)){
    _streamController = new StreamController();
    getProductsFromServer();
  }

  int? filterOn;

  void getProductsFromServer() async{
    state = AsyncLoading();
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
      receivedProducts = products;
      state = AsyncData(products) ;
    }
    else{
      developer.log(currentScreen, name: "Reponse was not successful");
    }
  }

  void doubleProducts(){
    /*List<Habit> _habits = [...state];
    final newHabit = Habit(title: title);
    _habits.add(newHabit);
    state = _habits ;*/

    List<Products> doubleProducts = [];
    doubleProducts.addAll(receivedProducts);
    doubleProducts.addAll(receivedProducts);
    developer.log(currentScreen, name : "Double product listing ${doubleProducts.length}");
    state = AsyncData(doubleProducts);
  }

  void filterProducts() async{

    String currentScreen = "ProductListingBloc";
    List<Products> products = receivedProducts;
    List<Products> filterdProducts = [];
    for(var singleProduct in products){
      if(singleProduct.id! < 3 ){
        filterdProducts.add(singleProduct);
      }

    }
    developer.log(currentScreen, name: "After filtering products size ${filterdProducts.length}");
    state = AsyncData(filterdProducts) ;
  }

  void testingStreams(){
    _streamController!.add("This a test data");
    _streamController!.addError(new Exception('An exception'));
    _streamController!.add("This a test data 2");
    _streamController!.close(); //Streams must be closed when not needed
  }
}

Stream<double> getRandomValues() async* {
  var random = Random(2);
  await Future.delayed(Duration(seconds: 1));
  yield random.nextDouble();

}
