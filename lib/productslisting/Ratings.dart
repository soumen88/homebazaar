import 'package:freezed_annotation/freezed_annotation.dart';

part 'Ratings.freezed.dart';
part 'Ratings.g.dart';

@freezed
abstract class Ratings with _$Ratings{
  @JsonSerializable(explicitToJson: true)
  const factory Ratings({
    required double? rate,
    required int? count,
    required String? title,
    required String? body
  }) = _Ratings;

  factory Ratings.fromJson(Map<String, dynamic> json) => _$RatingsFromJson(json);
}