import 'package:freezed_annotation/freezed_annotation.dart';

part 'CartProducts.g.dart';

@JsonSerializable()
class CartProducts {
  int? productId;
  int? quantity;

  CartProducts({this.productId, this.quantity});
  factory CartProducts.fromJson(Map<String, dynamic> json) => _$CartProductsFromJson(json);

  Map<String, dynamic> toJson() => _$CartProductsToJson(this);
}
