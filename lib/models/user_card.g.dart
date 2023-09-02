// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCardsObj _$UserCardsObjFromJson(Map<String, dynamic> json) => UserCardsObj(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => UserCardItemObj.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserCardsObjToJson(UserCardsObj instance) =>
    <String, dynamic>{
      'list': instance.list,
    };

UserCardItemObj _$UserCardItemObjFromJson(Map<String, dynamic> json) =>
    UserCardItemObj(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      company: json['company'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      qrCodeUrl: json['qrCodeUrl'] as String?,
      isMinted: json['isMinted'] as bool?,
    );

Map<String, dynamic> _$UserCardItemObjToJson(UserCardItemObj instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'company': instance.company,
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'qrCodeUrl': instance.qrCodeUrl,
      'isMinted': instance.isMinted,
    };

UserCardMintReqObj _$UserCardMintReqObjFromJson(Map<String, dynamic> json) =>
    UserCardMintReqObj(
      name: json['name'] as String?,
      email: json['email'] as String?,
      company: json['company'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      cardImageBase64: json['cardImageBase64'] as String?,
      faceImageBase64: json['faceImageBase64'] as String?,
    );

Map<String, dynamic> _$UserCardMintReqObjToJson(UserCardMintReqObj instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'company': instance.company,
      'title': instance.title,
      'description': instance.description,
      'cardImageBase64': instance.cardImageBase64,
      'faceImageBase64': instance.faceImageBase64,
    };
