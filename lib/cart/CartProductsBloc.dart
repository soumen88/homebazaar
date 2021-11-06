import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:homebazaar/cart/SavedProducts.dart';
import 'package:homebazaar/productslisting/Products.dart';
import 'dart:developer' as developer;
class CartProductsBloc extends ChangeNotifier{
  List<Products> currentProductsInCart = [];
  SplayTreeMap currentProductsMapInCart = new SplayTreeMap<int, List<Products>>();
  List<SavedProducts> savedProductsInCart = [];
  String currentScreen = "CartProductsBloc";
  void addAllProducts(SplayTreeMap productList, List<Products> productsReceived){
    currentProductsInCart = List.from(productsReceived);
    currentProductsMapInCart = SplayTreeMap.from(productList);
    productList.forEach((key, value) {
      if(value is List){
        developer.log(currentScreen, name: "Found products for length ${value.length}");
        SavedProducts savedProducts = new SavedProducts(value.length, value.first);
        savedProductsInCart.add(savedProducts);
      }
    });

    notifyListeners();
  }

  void changeProductCount(Products products){
    int counter = 0;
    for(SavedProducts currentProduct in savedProductsInCart){
      if(currentProduct.product.id! == products.id! ){
        savedProductsInCart.removeAt(counter);
        currentProduct.count = currentProduct.count! + 1 ;
        savedProductsInCart.insert(counter, currentProduct);
      }
      counter++;
    }
    notifyListeners();
  }
}