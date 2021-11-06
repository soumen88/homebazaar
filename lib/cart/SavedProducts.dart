import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:homebazaar/productslisting/Products.dart';

part 'SavedProducts.g.dart';

@JsonSerializable()
class SavedProducts {
  int? count;
  Products product;


  SavedProducts(this.count, this.product);

  factory SavedProducts.fromJson(Map<String, dynamic> json) => _$SavedProductsFromJson(json);

  Map<String, dynamic> toJson() => _$SavedProductsToJson(this);
}
