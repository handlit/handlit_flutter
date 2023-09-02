// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_auth_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTokenObj _$UserTokenObjFromJson(Map<String, dynamic> json) => UserTokenObj(
      userToken: json['userToken'] as String?,
    );

Map<String, dynamic> _$UserTokenObjToJson(UserTokenObj instance) =>
    <String, dynamic>{
      'userToken': instance.userToken,
    };

UserAuthInfoObj _$UserAuthInfoObjFromJson(Map<String, dynamic> json) =>
    UserAuthInfoObj(
      isAuth: json['isAuth'] as bool?,
      user: json['user'] == null
          ? null
          : UserObj.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserAuthInfoObjToJson(UserAuthInfoObj instance) =>
    <String, dynamic>{
      'isAuth': instance.isAuth,
      'user': instance.user,
    };

UserObj _$UserObjFromJson(Map<String, dynamic> json) => UserObj(
      userId: json['userId'] as String?,
      accessHash: json['accessHash'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      phone: json['phone'] as String?,
      telegramId: json['telegramId'] as String?,
      userName: json['userName'] as String?,
    );

Map<String, dynamic> _$UserObjToJson(UserObj instance) => <String, dynamic>{
      'userId': instance.userId,
      'accessHash': instance.accessHash,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phone': instance.phone,
      'telegramId': instance.telegramId,
      'userName': instance.userName,
    };
