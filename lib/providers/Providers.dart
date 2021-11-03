import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebazaar/productslisting/ProductListingBloc.dart';
import 'package:homebazaar/productslisting/Products.dart';

final productListProvider = StateNotifierProvider<ProductListingNotifierBloc, AsyncValue<List<Products>?>>((ref) {
  return ProductListingNotifierBloc();
});
