import 'package:freezed_annotation/freezed_annotation.dart';

part 'GeoLocation.g.dart';

@JsonSerializable()
class GeoLocation {
  String? lat;
  String? long;

  GeoLocation({this.lat, this.long});
  factory GeoLocation.fromJson(Map<String, dynamic> json) => _$GeoLocationFromJson(json);

  Map<String, dynamic> toJson() => _$GeoLocationToJson(this);
}
