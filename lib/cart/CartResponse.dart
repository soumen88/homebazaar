import 'package:freezed_annotation/freezed_annotation.dart';

part 'CartResponse.freezed.dart';
part 'CartResponse.g.dart';

@freezed
abstract class CartResponse with _$CartResponse{
  @JsonSerializable(explicitToJson: true)
  const factory CartResponse({
    @JsonKey(name: "_id")
    required String? idFirst,
    required String? id,
    required int? userId,
    required String? date,
    required List? products
  }) = _CartResponse;

  factory CartResponse.fromJson(Map<String, dynamic> json) => _$CartResponseFromJson(json);
}