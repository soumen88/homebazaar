import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebazaar/cart/CartProducts.dart';
import 'package:homebazaar/cart/CartResponse.dart';
import 'package:homebazaar/cart/SavedProducts.dart';
import 'dart:developer' as developer;

class CartBloc extends StateNotifier<AsyncValue<CartResponse?>>{
  CartBloc(AsyncValue<CartResponse?> state) : super(state);
  String currentScreen = "CartBloc";
  void placeOrder(String userId, List<SavedProducts> productList){
    List<CartProducts> cartProductList = [];
    for(var currentProduct in productList){
      var cartProducts = CartProducts(productId: currentProduct.product.id! , quantity: currentProduct.count!);
      cartProductList.add(cartProducts);
    }
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);

    developer.log(currentScreen, name: "Current date ${date}");

    var jsonString = jsonEncode(cartProductList);

  }
}