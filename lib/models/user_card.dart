import 'package:json_annotation/json_annotation.dart';
part 'user_card.g.dart';

@JsonSerializable()
class UserCardsObj {
  final List<UserCardItemObj>? list;

  const UserCardsObj({this.list});

  factory UserCardsObj.fromJson(Map<String, Object?> json) => _$UserCardsObjFromJson(json);
  Map<String, dynamic> toJson() => _$UserCardsObjToJson(this);
}

@JsonSerializable()
class UserCardItemObj {
  final String? id;
  final String? name;
  final String? email;
  final String? company;
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? qrCodeUrl;
  final bool? isMinted;

  const UserCardItemObj({this.id, this.name, this.email, this.company, this.title, this.description, this.imageUrl, this.qrCodeUrl, this.isMinted});
  factory UserCardItemObj.fromJson(Map<String, Object?> json) => _$UserCardItemObjFromJson(json);
  Map<String, dynamic> toJson() => _$UserCardItemObjToJson(this);
}

@JsonSerializable()
class UserCardMintReqObj {
  String? name;
  String? email;
  String? company;
  String? title;
  String? description;
  String? cardImageBase64;
  String? faceImageBase64;

  UserCardMintReqObj({this.name, this.email, this.company, this.title, this.description, this.cardImageBase64, this.faceImageBase64});
  Map<String, dynamic> toJson() => _$UserCardMintReqObjToJson(this);
}
