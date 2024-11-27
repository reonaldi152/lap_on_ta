import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class Users {
  Users({this.id, this.name, this.email, this.phone, this.roles, this.createdAt, this.updatedAt});

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);

  Map<String, dynamic> toJson() => _$UsersToJson(this);

  final dynamic id;
  final dynamic name;
  final dynamic email;
  final dynamic phone;
  final dynamic roles;
  @JsonKey(name: 'created_at')
  final dynamic createdAt;
  @JsonKey(name: 'updated_at')
  final dynamic updatedAt;

  @override
  String toString() => json.encode(this);

}