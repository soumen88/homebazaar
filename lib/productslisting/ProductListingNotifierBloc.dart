import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebazaar/chopper/ApiService.dart';
import 'package:homebazaar/productslisting/Products.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
String currentScreen = "ProductListingBloc";



class ProductListingNotifierBloc extends StateNotifier<AsyncValue<List<Products>?>>{
  List<Products> receivedProducts = [];
  StreamController<String>? _streamController;
  StreamController<String> get streamController => _streamController!;
  List<Products> get receivedProductsFromApi => receivedProducts;

  List<Products> cartProducts = [];
  SplayTreeMap cartProductsMap = new SplayTreeMap<int, List<Products>>();
  List<Products> get getProductsFromCart => cartProducts;
  SplayTreeMap get getProductsFromCartMap => cartProductsMap;
  ProductListingNotifierBloc() : super(AsyncData(null)){
    _streamController = new StreamController();
  }

  int? filterOn = 5;

  void getProductsFromServer() async{
    state = AsyncLoading();
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      final quoteService = ApiService.instance;
      final response = await quoteService.getProducts();
      String currentScreen = "ProductListingBloc";
      List<Products> products = [];
      if (response != null && response.isNotEmpty) {
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
    else if(connectivityResult == ConnectivityResult.none){
      state = AsyncData(receivedProducts);
    }


  }

  void getSingleProductDetails(int productId) async{
    developer.log(currentScreen, name : "Selected product id from server ${productId}");
    List<Products> products = receivedProducts.where((element) => element.id! == productId).toList();
    developer.log(currentScreen, name: "Reponse was successful with size ${products.length}");
    for(var currentProduct in products){
      developer.log(currentScreen,name : "Product name after fetch ${currentProduct.id}");
    }
    state = AsyncData(products) ;
  }

  void saveProductDetails(Products displayProduct) async{
    List<Products> list = [displayProduct];
    state = AsyncData(list) ;
  }

  void loadPreviousProducts(){
    state = AsyncLoading();
    developer.log(currentScreen, name: "Previous products found ${receivedProducts.length}");
    state = AsyncData(receivedProducts) ;
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

  void sortAlphabetical(){
    state = AsyncLoading();
    receivedProducts.sort((a,b) => a.title!.toLowerCase().compareTo(b.title!.toLowerCase()));
    state = AsyncData(receivedProducts) ;
  }

  void sortReverseAlphabetical(){
    state = AsyncLoading();
    receivedProducts.sort((a,b) => b.title!.toLowerCase().compareTo(a.title!.toLowerCase()));
    state = AsyncData(receivedProducts) ;
  }

  void addProductToCart(Products products){
    cartProducts.add(products);
    if(cartProductsMap.containsKey(products.id!)){
      List<Products> currentProducts = cartProductsMap[products.id!];
      currentProducts.add(products);
      cartProductsMap[products.id!] = currentProducts;
    }
    else{
      List<Products> currentProducts = [products];
      cartProductsMap[products.id!] = currentProducts;
    }
    developer.log(currentScreen , name : "Current product added to cart ${products.id}");

  }

  void getSavedProductsfromCart(){
    state = AsyncData(cartProducts);
    developer.log(currentScreen , name : "Current product added to cart ${cartProducts.length}");
  }

  void clearCart(){
    cartProducts.clear();
  }
}

