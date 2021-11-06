import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebazaar/cart/SavedProducts.dart';

class SavedProductsBloc extends StateNotifier<AsyncValue<List<SavedProducts>?>>{
  SavedProductsBloc() : super(AsyncData(null));

  List<SavedProducts> savedProducts = [];
  void addProductForCheckout(SavedProducts currentProduct){
    savedProducts.add(currentProduct);
  }

  void getAllSavedProductsList(){
    state = AsyncData(savedProducts);
  }

}