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

  void changeProductCount(Products products, bool isAdded){
    int index = savedProductsInCart.indexWhere((element) => element.product.id == products.id);
    if(index == -1){
      //element not found
      developer.log(currentScreen, name: "Element not found hence adding in list");
      SavedProducts savedProducts = new SavedProducts(1, products);
      savedProductsInCart.add(savedProducts);
    }
    else{
      developer.log(currentScreen, name: "Element found at index $index in list");
      SavedProducts savedProducts =  savedProductsInCart.elementAt(index);
      savedProducts.count = savedProducts.count! + 1;
      savedProductsInCart.removeAt(index);
      savedProductsInCart.insert(index, savedProducts);
    }
    notifyListeners();
  }

  void removeProductFromCart(Products savedProducts){
    savedProductsInCart.removeWhere((element) => element.product.id! == savedProducts.id!);
    notifyListeners();
  }
}