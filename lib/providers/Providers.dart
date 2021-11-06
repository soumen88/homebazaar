import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebazaar/cart/SavedProducts.dart';
import 'package:homebazaar/cart/SavedProductsBloc.dart';
import 'package:homebazaar/components/QuantityBloc.dart';
import 'package:homebazaar/components/QuantityCounter.dart';
import 'package:homebazaar/login/UserAuthenticateBloc.dart';
import 'package:homebazaar/productslisting/ProductListingNotifierBloc.dart';
import 'package:homebazaar/productslisting/Products.dart';
import 'package:homebazaar/singleproduct/SingleProductNotifierBloc.dart';

final productListProvider = StateNotifierProvider.autoDispose<ProductListingNotifierBloc, AsyncValue<List<Products>?>>((ref) {
  return ProductListingNotifierBloc();
});

final savedProductListProvider = StateNotifierProvider.autoDispose<SavedProductsBloc, AsyncValue<List<SavedProducts>?>>((ref) {
  return SavedProductsBloc();
});

final counterProvider = ChangeNotifierProvider.autoDispose<QuantityBloc>((ref) => QuantityBloc());

final authenticateProvider = StateNotifierProvider.autoDispose<UserAuthenticateBloc, AsyncValue<bool>>((ref) {
  return UserAuthenticateBloc();
});
