import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LoginModel {
  String? userName;
  String? password;

  LoginModel(this.userName, this.password);

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(json['userName'] as String, json['password'] as String);
  }

  Map<String, dynamic> toJson() =>
      {'userName': this.userName, 'password': this.password};
}
