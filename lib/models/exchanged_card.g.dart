// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchanged_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExchangedCardListObj _$ExchangedCardListObjFromJson(
        Map<String, dynamic> json) =>
    ExchangedCardListObj(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => ExchangedCardItemObj.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExchangedCardListObjToJson(
        ExchangedCardListObj instance) =>
    <String, dynamic>{
      'list': instance.list,
    };

ExchangedCardItemObj _$ExchangedCardItemObjFromJson(
        Map<String, dynamic> json) =>
    ExchangedCardItemObj(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      company: json['company'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      qrCodeUrl: json['qrCodeUrl'] as String?,
      isMinted: json['isMinted'] as bool?,
      faceUrl: json['faceUrl'] as String?,
    );

Map<String, dynamic> _$ExchangedCardItemObjToJson(
        ExchangedCardItemObj instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'company': instance.company,
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'faceUrl': instance.faceUrl,
      'qrCodeUrl': instance.qrCodeUrl,
      'isMinted': instance.isMinted,
    };
