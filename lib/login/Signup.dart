import 'package:freezed_annotation/freezed_annotation.dart';

part 'Signup.g.dart';

@JsonSerializable()
class Signup {
  String? email;
  String? password;

  Signup({this.email, this.password});
  factory Signup.fromJson(Map<String, dynamic> json) => _$SignupFromJson(json);

  Map<String, dynamic> toJson() => _$SignupToJson(this);
}
