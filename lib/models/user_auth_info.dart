import 'package:json_annotation/json_annotation.dart';

part 'user_auth_info.g.dart';

@JsonSerializable()
class UserAuthInfoObj {
  final bool? isAuth;
  final UserObj? user;

  const UserAuthInfoObj({this.isAuth, this.user});
  factory UserAuthInfoObj.fromJson(Map<String, dynamic> json) => _$UserAuthInfoObjFromJson(json);
  Map<String, dynamic> toJson() => _$UserAuthInfoObjToJson(this);
}

@JsonSerializable()
class UserObj {
  final String? userId;
  final String? accessHash;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? telegramId;
  final String? userName;

  const UserObj({this.userId, this.accessHash, this.firstName, this.lastName, this.phone, this.telegramId, this.userName});
  factory UserObj.fromJson(Map<String, dynamic> json) => _$UserObjFromJson(json);
  Map<String, dynamic> toJson() => _$UserObjToJson(this);
}
