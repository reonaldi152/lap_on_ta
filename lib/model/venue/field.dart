import 'dart:convert';

import 'package:flutter_lapon/model/owner/owner.dart';
import 'package:json_annotation/json_annotation.dart';

import '../category/category.dart';

part 'field.g.dart';

@JsonSerializable()
class Field {
  Field({this.id,this.venueID, this.name, this.description, this.image,this.price, this.createdAt, this.updatedAt,});

  factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);

  Map<String, dynamic> toJson() => _$FieldToJson(this);

  final dynamic id;
  @JsonKey(name: 'venue_id')
  final dynamic venueID;
  final dynamic name;
  final dynamic description;
  final dynamic image;
  final dynamic price;
  @JsonKey(name: 'created_at')
  final dynamic createdAt;
  @JsonKey(name: 'updated_at')
  final dynamic updatedAt;


  @override
  String toString() => json.encode(this);

}