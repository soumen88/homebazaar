import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebazaar/productslisting/ProductListingNotifierBloc.dart';
import 'package:homebazaar/productslisting/Products.dart';
import 'package:homebazaar/singleproduct/SingleProductNotifierBloc.dart';

final productListProvider = StateNotifierProvider.autoDispose<ProductListingNotifierBloc, AsyncValue<List<Products>?>>((ref) {
  return ProductListingNotifierBloc();
});
