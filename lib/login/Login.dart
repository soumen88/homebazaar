import 'package:freezed_annotation/freezed_annotation.dart';

part 'Login.g.dart';

@JsonSerializable()
class Login {
  String? username;
  String? password;

  Login({this.username, this.password});
  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);

  Map<String, dynamic> toJson() => _$LoginToJson(this);
}
