import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebazaar/components/QuantityBloc.dart';
import 'package:homebazaar/components/QuantityCounter.dart';
import 'package:homebazaar/productslisting/ProductListingNotifierBloc.dart';
import 'package:homebazaar/productslisting/Products.dart';
import 'package:homebazaar/singleproduct/SingleProductNotifierBloc.dart';

final productListProvider = StateNotifierProvider.autoDispose<ProductListingNotifierBloc, AsyncValue<List<Products>?>>((ref) {
  return ProductListingNotifierBloc();
});

final counterProvider = ChangeNotifierProvider<QuantityBloc>((ref) => QuantityBloc());
