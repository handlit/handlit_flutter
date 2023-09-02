import 'package:json_annotation/json_annotation.dart';

part 'exchanged_card.g.dart';

@JsonSerializable()
class ExchangedCardListObj {
  final List<ExchangedCardItemObj>? list;

  const ExchangedCardListObj({this.list});
  factory ExchangedCardListObj.fromJson(Map<String, dynamic> json) => _$ExchangedCardListObjFromJson(json);
  Map<String, dynamic> toJson() => _$ExchangedCardListObjToJson(this);
}

@JsonSerializable()
class ExchangedCardItemObj {
  final String? id;
  final String? name;
  final String? email;
  final String? company;
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? qrCodeUrl;
  final bool? isMinted;

  const ExchangedCardItemObj({this.id, this.name, this.email, this.company, this.title, this.description, this.imageUrl, this.qrCodeUrl, this.isMinted});
  factory ExchangedCardItemObj.fromJson(Map<String, dynamic> json) => _$ExchangedCardItemObjFromJson(json);
  Map<String, dynamic> toJson() => _$ExchangedCardItemObjToJson(this);
}
