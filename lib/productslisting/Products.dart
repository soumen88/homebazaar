import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:homebazaar/productslisting/Ratings.dart';

part 'Products.freezed.dart';
part 'Products.g.dart';

@freezed
abstract class Products with _$Products{

  const factory Products({
    int?  id,
    String?  title,
    double?  price,
    String?  description,
    String?  category,
    String?  image,
    Ratings?  rating
  }) = _Products;

  factory Products.fromJson(Map<String, dynamic> json) => _$ProductsFromJson(json);

}