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
  List<Products> get receivedProductsFromApi => receivedProducts;

  List<Products> cartProducts = [];
  List<Products> get getProductsFromCart => cartProducts;
  ProductListingNotifierBloc() : super(AsyncData(null)){
    _streamController = new StreamController();
    getProductsFromServer();
  }

  int? filterOn = 5;

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

  void getSingleProductDetails(int productId) async{
    developer.log(currentScreen, name : "Selected product id from server ${productId}");
    List<Products> products = receivedProducts.where((element) => element.id! == productId).toList();
    developer.log(currentScreen, name: "Reponse was successful with size ${products.length}");
    state = AsyncData(products) ;
  }

  void orderDecending(){
    state = AsyncLoading();
    receivedProducts.sort((a,b) => b.price!.compareTo(a.price!));
    state = AsyncData(receivedProducts) ;
  }
  void orderAscending(){
    state = AsyncLoading();
    receivedProducts.sort((a,b) => a.price!.compareTo(b.price!));
    state = AsyncData(receivedProducts) ;
  }

  void addProductToCart(Products products){
    cartProducts.add(products);
    developer.log(currentScreen , name : "Current product added to cart ${products.id}");
  }

  void getProductsfromCart(){

    developer.log(currentScreen , name : "Current product added to cart ${cartProducts.length}");
  }
}

Stream<double> getRandomValues() async* {
  var random = Random(2);
  await Future.delayed(Duration(seconds: 1));
  yield random.nextDouble();

}

