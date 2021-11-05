import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:homebazaar/login/Address.dart';
import 'package:homebazaar/login/GeoLocation.dart';
import 'package:homebazaar/login/UserDetails.dart';

part 'User.g.dart';

@JsonSerializable()
class User {
  String? email;
  String? username;
  String? password;
  UserDetails? name;
  Address? address;
  String? phone;


  User({this.email, this.username, this.password, this.name, this.address, this.phone});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
