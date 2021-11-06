import 'package:flutter/material.dart';
import 'package:homebazaar/productslisting/Products.dart';
import 'dart:developer' as developer;
class CartProductsBloc extends ChangeNotifier{
  List<Products> currentProductsInCart = [];
  String currentScreen = "CartProductsBloc";
  void addAllProducts(List<Products> productList){
     currentProductsInCart = List.from(productList);
     developer.log(currentScreen, name: "Found products for length ${productList.length}");
     notifyListeners();
  }
}