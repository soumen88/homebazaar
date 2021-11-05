import 'package:freezed_annotation/freezed_annotation.dart';

part 'UserDetails.g.dart';

@JsonSerializable()
class UserDetails {
  String? firstname;
  String? lastname;

  UserDetails({this.firstname, this.lastname});
  factory UserDetails.fromJson(Map<String, dynamic> json) => _$UserDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);
}
