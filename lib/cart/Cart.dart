import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:homebazaar/cart/CartProducts.dart';

part 'Cart.g.dart';

@JsonSerializable()
class Cart {
  int? userId;
  String? date;
  List<CartProducts>? products;

  Cart(this.userId, this.date, this.products);

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);
}
