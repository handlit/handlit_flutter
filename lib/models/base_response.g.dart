// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponseObject<T> _$BaseResponseObjectFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BaseResponseObject<T>(
      error: json['error'] as bool,
      value: _$nullableGenericFromJson(json['value'], fromJsonT),
      errorName: json['errorName'] as String?,
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => ResponseErrorStatus.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BaseResponseObjectToJson<T>(
  BaseResponseObject<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'error': instance.error,
      'value': _$nullableGenericToJson(instance.value, toJsonT),
      'errorName': instance.errorName,
      'errors': instance.errors,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
