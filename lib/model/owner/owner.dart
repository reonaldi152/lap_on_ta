import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'owner.g.dart';

@JsonSerializable()
class Owner {
  Owner({this.id, this.name, this.email, this.phone, this.photoProfile, this.photoKTP, this.createdAt, this.updatedAt});

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerToJson(this);

  final dynamic id;
  final dynamic name;
  final dynamic email;
  final dynamic phone;
  @JsonKey(name: 'photo_profile')
  final dynamic photoProfile;
  @JsonKey(name: 'photo_ktp')
  final dynamic photoKTP;
  @JsonKey(name: 'created_at')
  final dynamic createdAt;
  @JsonKey(name: 'updated_at')
  final dynamic updatedAt;

  @override
  String toString() => json.encode(this);

}