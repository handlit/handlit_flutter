// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this, unnecessary_null_in_if_null_operators, avoid_print, prefer_if_null_operators, depend_on_referenced_packages
import 'package:handlit_flutter/repositories/api/exception/exception_wrapper.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResponseObject<T> {
  final bool error;
  final T? value;
  final String? errorName;
  final List<ResponseErrorStatus>? errors;

  BaseResponseObject({
    required this.error,
    this.value,
    this.errorName,
    this.errors,
  });

  factory BaseResponseObject.fromJson(Map<String, Object?> json, T Function(Object? json) fromJsonT) => _$BaseResponseObjectFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$BaseResponseObjectToJson(this, toJsonT);
}
