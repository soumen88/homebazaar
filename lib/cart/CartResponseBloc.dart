import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebazaar/cart/Cart.dart';
import 'package:homebazaar/cart/CartProducts.dart';
import 'package:homebazaar/cart/CartResponse.dart';
import 'package:homebazaar/cart/SavedProducts.dart';
import 'dart:developer' as developer;

import 'package:homebazaar/chopper/ApiService.dart';

class CartResponseBloc extends StateNotifier<AsyncValue<CartResponse?>>{

  CartResponseBloc() : super(AsyncData(null));

  String currentScreen = "CartBloc";

  void placeOrder(String userId, List<SavedProducts> productList) async{
    state = AsyncLoading();
    List<CartProducts> cartProductList = [];
    for(var currentProduct in productList){
      var cartProducts = CartProducts(productId: currentProduct.product.id! , quantity: currentProduct.count!);
      cartProductList.add(cartProducts);
    }

    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);

    Cart cart = new Cart(5, date.toString(), cartProductList);

    developer.log(currentScreen, name: "Current date ${date}");

    var jsonString = jsonEncode(cart);

    final quoteService = ApiService.instance;
    final response = await quoteService.placeOrder(cart);
    CartResponse? cartResponse;
    if (response != null ) {
      cartResponse = CartResponse.fromJson(response);
      developer.log(currentScreen, name: "String ${cartResponse.userId} and ${cartResponse.idFirst}");

    }
    state = AsyncData(cartResponse);
  }
}