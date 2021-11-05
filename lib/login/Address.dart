import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:homebazaar/login/GeoLocation.dart';

part 'Address.g.dart';

@JsonSerializable()
class Address {
  String? city;
  String? street;
  int? number;
  String? zipcode;
  GeoLocation? geolocation;


  Address({this.city, this.street, this.number, this.zipcode, this.geolocation});

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
