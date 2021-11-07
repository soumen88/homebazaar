import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebazaar/cart/CartProductsBloc.dart';
import 'package:homebazaar/cart/CartResponse.dart';
import 'package:homebazaar/cart/CartResponseBloc.dart';
import 'package:homebazaar/cart/SavedProducts.dart';
import 'package:homebazaar/cart/SavedProductsBloc.dart';
import 'package:homebazaar/components/QuantityBloc.dart';
import 'package:homebazaar/connectivity/AppConnectivity.dart';
import 'package:homebazaar/connectivity/ConnectivityDetectorBloc.dart';
import 'package:homebazaar/login/UserAuthenticateBloc.dart';
import 'package:homebazaar/productslisting/ProductListingNotifierBloc.dart';
import 'package:homebazaar/productslisting/Products.dart';
import 'package:homebazaar/splashscreen/TimerDurationBloc.dart';

final productListProvider = StateNotifierProvider<ProductListingNotifierBloc, AsyncValue<List<Products>?>>((ref) {
  return ProductListingNotifierBloc();
});

final savedProductListProvider = StateNotifierProvider.autoDispose<SavedProductsBloc, AsyncValue<List<SavedProducts>?>>((ref) {
  return SavedProductsBloc();
});

final counterProvider = ChangeNotifierProvider.autoDispose<QuantityBloc>((ref) => QuantityBloc());

final cartProductsNotifier = ChangeNotifierProvider.autoDispose<CartProductsBloc>((ref) => CartProductsBloc());

final authenticateProvider = StateNotifierProvider.autoDispose<UserAuthenticateBloc, AsyncValue<bool>>((ref) {
  return UserAuthenticateBloc();
});

final cartListProvider = StateNotifierProvider.autoDispose<CartResponseBloc, AsyncValue<CartResponse?>>((ref) {
  return CartResponseBloc();
});

final connectivityProvider = StateNotifierProvider<ConnectivityDetectorBloc, AsyncValue<AppConnectivity?>>((ref) {
  return ConnectivityDetectorBloc();
});


final durationProvider = StateNotifierProvider<TimerDurationBloc, AsyncValue<bool>>((ref) {
  return TimerDurationBloc();
});