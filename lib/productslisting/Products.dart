import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:homebazaar/productslisting/Ratings.dart';

part 'Products.freezed.dart';
part 'Products.g.dart';

@freezed
abstract class Products with _$Products{
  @JsonSerializable(explicitToJson: true)
  const factory Products({
    required int?  id,
    required String?  title,
    required double?  price,
    required String?  description,
    required String?  category,
    required String?  image,
    required Ratings?  rating,
    @JsonKey()
    required int? addedCount,
  }) = _Products;

  factory Products.fromJson(Map<String, dynamic> json) => _$ProductsFromJson(json);


}